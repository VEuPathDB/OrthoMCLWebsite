<?php
/**
 * View of database stats
 * @package View
 */

require_once dirname(__FILE__) . "/../lib/modules/DBInstances.php";
require_once dirname(__FILE__) . "/../lib/modules/Database.php";
require_once dirname(__FILE__) . "/../lib/LdapTnsNameResolver.php";

$ldap_resolver = new LdapTnsNameResolver();

$db_instances_obj = new DBInstances();
$db_instances_attribs = $db_instances_obj->attributes();
$db_instances_str = $db_instances_attribs{'DbInstanceNames'};
$db_names = explode(',', $db_instances_str);

/**
 * Loop through available DBs by name and display attributes for each
 */
foreach ($db_names as $db_name) {

  $database = new Database($db_name);
  $db_display_name = ucfirst(strtolower($db_name));

  if (isset($_GET['refresh']) && $_GET['refresh'] == 1) {
    $success = $database->refresh();
    // TODO - put this warning near the refresh button where it is better noticed
    if ( ! $success) {print "<font color='red'>FAILED TO REFRESH</font>";}
  }

  $adb = $database->attributes();
  $adb_aliases_ar = $ldap_resolver->resolve($adb{'service_name'});
?>

<h2><?php print $db_display_name ?> Database</h2>

<p>
  <b>Identifiers</b>:
  <table border="0" cellspacing="3" cellpadding="2" align="">
    <tr class="secondary3">
      <th><font size="-2">Identifier</font></th>
      <th><font size="-2">Value</font></th>
      <th></th>
    </tr>
    <tr class="rowLight">
      <td>Service Name</td>
      <td><?php print strtolower($adb{'service_name'}) ?></td>
      <td><a href='javascript:void()' style="text-decoration:none"
        onmouseover="return overlib(
         'result of <br><i>select&nbsp;sys_context(\'userenv\',&nbsp;\'service_name\')&nbsp;from&nbsp;dual</i>'
        )" onmouseout="return nd();"><sup>[?]</sup></a>
      </td>
    </tr>
    <tr class="rowMedium">
      <td>Instance Name</td>
      <td><?php print strtolower($adb{'instance_name'}) ?></td>
      <td><a href='javascript:void()' style="text-decoration:none"
        onmouseover="return overlib(
         'result of <br><i>select&nbsp;sys_context(\'userenv\',&nbsp;\'instance_name\')&nbsp;from&nbsp;dual</i>'
        )" onmouseout="return nd();"><sup>[?]</sup></a>
      </td>
    </tr>
    <tr class="rowLight">
      <td>Global Name</td>
      <td><?php print strtolower($adb{'global_name'}) ?></td>
      <td><a href='javascript:void()' style="text-decoration:none"
        onmouseover="return overlib(
         'result of <br><i>select&nbsp;sys_context(\'userenv\',&nbsp;\'global_name\')&nbsp;from&nbsp;dual</i>'
        )" onmouseout="return nd();"><sup>[?]</sup></a>
      </td>
    </tr>
    <tr class="rowMedium">
      <td>DB Unique Name</td>
      <td><?php print strtolower($adb{'db_unique_name'}) ?></td>
      <td><a href='javascript:void()' style="text-decoration:none"
        onmouseover="return overlib(
         'result of <br><i>select&nbsp;sys_context(\'userenv\',&nbsp;\'db_unique_name\')&nbsp;from&nbsp;dual</i>'
        )" onmouseout="return nd();"><sup>[?]</sup></a></td>
    </tr>
  </table>
</p>

<p>
  <b>Aliases</b> (from LDAP): <?php print implode(", ", $adb_aliases_ar) ?><br/><br/>
  <b>Hosted on</b>: <?php print strtolower($adb{'server_name'})?><br/>
  <b>Oracle Version</b>: <?php print $adb{'version'}?>
</p>
<p>
  <b>Client login name</b>: <?php print strtolower($adb{'login'})?><br/>
  <b>Client connecting from</b>: <?php print strtolower($adb{'client_host'})?><br/>
  <b>Client OS user</b>: <?php print strtolower($adb{'os_user'})?>
</p>

<p>
  <b>Available DBLinks</b>:
  <table border="0" cellspacing="3" cellpadding="2" align="">
    <tr class="secondary3">
      <th align="left"><font size="-2">owner</font></th>
      <th align="left"><font size="-2">db_link</font></th>
      <th align="left"><font size="-2">username</font></th>
      <th align="left"><font size="-2">host</font></th>
      <th align="left"><font size="-2">created</font></th>
      <th align="left"><font size="-2">valid</font></th>
    </tr>
<?php
$dblink_map = $adb{'DblinkList'};
$row = 0;
foreach ($dblink_map as $dblink) {
  $css_class = ($row % 2) ? "rowMedium" : "rowLight";
?>
    <tr class="<?php print $css_class?>" >
      <td><?php print strtolower($dblink{'owner'})?></td>
      <td><?php print strtolower($dblink{'db_link'})?></td>
      <td><?php print strtolower($dblink{'username'})?></td>
      <td><?php print strtolower($dblink{'host'})?></td>
      <td><?php print strtolower($dblink{'created'})?></td>
      <td align='center'><?php print ($dblink{'isValid'} == '1') ? "<span style='color:green''>&#10004;</span>" : "<span style='color:red'>&#10008;</span>"  ?></td>
    </tr>
<?php
  $row++;
}
?>
  </table>
</p>

<hr/>
<b>Information on this page was last updated</b>: <?php print $adb{'system_date'}?><br/>
<form method="GET" action="">
  <input name="refresh" type="hidden" value="1">
  <input type="submit" value="update now">
</form>
<p>

<?php } ?>
<!-- End DB sections -->

