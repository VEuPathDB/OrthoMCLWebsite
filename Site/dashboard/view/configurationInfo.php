<?php
/**
 * Information about WDK configuration.
 * @package View
 */

require_once dirname(__FILE__) . "/../lib/modules/ModelConfig.php";
require_once dirname(__FILE__) . "/../lib/modules/WdkProperties.php";

$model_config = new ModelConfig();
$properties_config = new WdkProperties();

$model_data_tree = $model_config->attributes();
$properties = $properties_config->attributes();

?>

<h2>Configuration</h2>

<p class="smalltext"><span class="expand_all clickable smalltext">expand all</span> | <span class="collapse_all clickable smalltext">collapse all</span></p>

<p class="clickable">WDK Model Configuration &#8593;&#8595;</p>
<div class="expandable" style="padding: 5px;">
        The following configurations were obtained from the WDK's running instance of the ModelConfig* classes. These generally represent values defined in
        the <code>model-config.xml</code> <i>at the time the webapp was loaded</i>,
        although some properties shown may have been added by the WDK's internals. Passwords have been masked in this display.<br>
        <i>This information is </i><b>not</b><i> suitable for
        copying directly into the model-config.xml as the attribute names shown here may not match the RNG spec.</i>

<pre>
<?php
ksort($model_data_tree);
foreach ($model_data_tree as $section => $data) {
  print "<b>" . $section . "</b><blockquote>" ;
  ksort($data);
  foreach ($data as $k => $v) {
    print $k . " = " . htmlentities($v) . "\n";
  }
  print "</blockquote>";
}
?>
</pre>


</div>


<p class="clickable">WDK Properties &#8593;&#8595;</p>
<div class="expandable" style="padding: 5px;">

<p>
WDK built-in properties and properties defined in
the <code>model.prop</code> <i>at the time the webapp was loaded</i>.
</p>
<pre>
<?php
ksort($properties);
foreach ($properties as $k => $v) {
  print $k . " = " . htmlentities($v) . "\n";
}
?>
</pre>
</div>
</p>
