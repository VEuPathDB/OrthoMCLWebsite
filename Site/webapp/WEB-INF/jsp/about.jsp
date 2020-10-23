<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:imp="urn:jsptagdir:/WEB-INF/tags/imp">
  <jsp:directive.page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"/>
  <imp:pageFrame title="${wdkModel.displayName} :: About" refer="about" bufferContent="false">
    <div id="about">
      <!-- Provides section-selection drop-down
      <div id="top" class="about-nav">
          <form>
            <select id="navSel" onchange="window.location='#'+$(this).find(':selected').attr('name');">
              <option name="">Jump to...</option>
              <option name="release">Current Release 6.1</option>
              <option name="forming_groups">Method for Forming and Expanding Ortholog Groups</option>
              <option name="orthomcl_algorithm">The OrthoMCL Algorithm</option>
              <option name="background">Background on Orthology and Prediction</option>
              <option name="faq">Frequently Asked Questions</option>
              <option name="software">Software</option>
              <option name="pubs">Publications</option>
              <option name="acknowledge">Acknowledgements</option>
              <option name="contact">Contact</option>
            </select>
          </form>
        </a>
      </div> -->
      <div class="about-title">
        <h1>About OrthoMCL</h1>
      </div>

      <div class="about-body">

        <div id="release" class="section-title">
          <h2>Current Release 6.2</h2>
        </div>
        <div class="section-content">
          <p>
	    In this release, 19 <b>Peripheral</b> species were added. Thus, OrthoMCL now predicts orthology for a total of 563 organisms (413 <b>Peripheral</b> and 150 <b>Core</b>) organisms). Proteins from the 19 new species were mapped into <b>Core</b> ortholog groups. Then, a new set of <b>Residual</b> ortholog groups (e.g. OG6r2_101799) were formed from the collection of all unmapped <b>Peripheral</b> proteins. See below for the methods.
	  </p>
	  <p>
	    To see the current set of organisms, their taxonomic category, their Core/Peripheral status, their abbreviation
	    for this site, and the source of their protein sequences, go to 
            <a href="${pageContext.request.contextPath}/getDataSummary.do?summary=data" target="_blank">Proteome Sources</a>.
            To see the number of sequences and ortholog groups for each organism, go to 
            <a href="${pageContext.request.contextPath}/getDataSummary.do?summary=release" target="_blank">Proteome Statistics</a>.
          </p>
          <p>
            <strong>Downloads:</strong>
            Go to the <a href="/common/downloads" target="_blank">download site</a> to obtain the protein sequences
            and ortholog groups used in this release.
          </p>
        </div>

        <div id="forming_groups" class="section-title">
          <h2>Method for Forming and Expanding Ortholog Groups</h2>
        </div>
        <div class="section-content">
          <p>
	    Proteins are placed into Ortholog Groups by the following steps:
	  <ol>
	    <li>The OrthoMCL algorithm (see below) is employed on proteins from a set of 150 <b>Core</b> species to form <b>Core</b> ortholog groups. These species were carefully chosen based on proteome quality and widespread placement across the tree of life. Each Core protein is placed by the algorithm into a <b>Core</b> ortholog group consisting of one or more proteins. Core group names have the format OG6_xxxxxx (e.g., OG6_101327). OG6 refers to OrthoMCL release 6; for each sub-release (e.g., 6.1, 6.2, etc), the Core species and the Core ortholog group names will remain constant.</li>
	    <li>The proteins from hundreds of additional organisms, termed <b>Peripheral</b> organisms, are mapped into the Core groups. To do this, NCBI BLASTP is used to compare each Peripheral protein to each Core protein in the Core groups. (Note that Peripheral proteins that were previously added to the Core group are NOT used in the BLASTP.) Then, each <b>Peripheral</b> protein is assigned to the Core group containing the Core protein with the best BLAST score, but only if the E-Value is &lt;1e-5 and the percent match length is &gt;=50%.</li>
	    <li>All Peripheral proteins that fail to map to a Core group are collected and subjected to independent OrthoMCL analysis, forming <b>Residual</b> groups consisting of one or more proteins. Residual group names have the format OG6r1_xxxxxx (e.g., OG6r1_101327), where OG6 refers to release 6 and r1 refers to sub-release 1.</li>
	    <li>For each subsequent sub-release (which will occur every ~3 months along with other VEuPathDB sites), proteomes from additional <b>Peripheral</b> organisms will be processed as in steps 2 and 3 above. However, step 3 will differ slightly because the previous set of Residual groups will be disassembled, leaving the previous unmapped Peripheral proteins to be combined with the new unmapped Peripheral proteins. All of these proteins will be used to form new Residual groups (e.g., OG6r2_xxxxxx).</li>
	    <li>On occasion, the set of Core species will be re-defined, as more appropriate proteomes become available. In this case, new Core groups (e.g., OG7_xxxxxx) and Residual groups (e.g., OG7r1_xxxxxx) will be formed.</li>
	  </ol>
	  </p>
	  <p>
	    This design allows for the addition of proteomes at every sub-release (e.g., 6.1, 6.2, etc). Note that <b>Core</b> groups (e.g., OG6_101327) will remain between sub-releases, though these groups will expand as Peripheral proteins are mapped in. In contrast, <b>Residual</b> groups will exist only for that sub-release; thus, Residual groups are useful in allowing the user to find proteins related to their protein(s) of interest, but are not stable groups.
	  </p>

        </div>

        <div id="orthomcl_algorithm" class="section-title">
          <h2>The OrthoMCL Algorithm</h2>
        </div>
        <div class="section-content">
          <p>
            See the <b><a href="https://docs.google.com/document/d/1RB-SqCjBmcpNq-YbOYdFxotHGuU7RK_wqxqDAMjyP_w/pub" target="_blank">OrthoMCL Algorithm Document</a></b> for a detailed description of the OrthoMCL algorithm.
            
          </p>
           In overview:
           <ul class="cirbulletlist">
           <li>All-v-all BLASTP of the proteins.</li>
           <li>Compute <i>percent match length</i>
             <ul class="cirbulletlist">
             <li>Select whichever is shorter, the query or subject sequence.  Call that sequence S.</li>
             <li>Count all amino acids in S that participate in any HSP.</li>
             <li>Divide that count by the length of S and multiply by 100</li>
             </ul>
           </li>
           <li>Apply thresholds to blast result.  Keep matches with E-Value &lt; 1e-5 percent match length &gt;= 50%</li>
           <li>Find potential inparalog, ortholog and co-ortholog <i>pairs</i> using the Orthomcl Pairs program.  (These are the pairs that are counted to form the <i>Average % Connectivity</i> statistic per group.)</li>
           <li>Use the <a href="http://micans.org/mcl/" target="_blank">MCL</a> program to cluster the pairs into groups</li>
           </ul>
        </div>

        <div id="background" class="section-title">
          <h2>Background on Orthology and Prediction</h2>
        </div>
        <div class="section-content">
          <p>
            Orthologs are homologs seperated by speciation events.  Paralogs are homologs separated
            by duplication events. Detection of orthologs is becoming much more important with the
            rapid progress in genome sequencing (<a href="https://academic.oup.com/mbe/article/36/10/2157/5523206" target="_blank">Glover et al. 2019</a>).
          </p>
          <p>
            OrthoMCL is a genome-scale algorithm for grouping orthologous protein sequences. It
            provides not only groups shared by two or more species/genomes, but also groups
            representing species-specific gene expansion families. Thus, it serves as an important
            utility for automated eukaryotic genome annotation. OrthoMCL starts with reciprocal best
            hits within each genome as potential in-paralog/recent paralog pairs and reciprocal best
            hits across any two genomes as potential ortholog pairs.  Related proteins are interlinked
            in a similarity graph. Then, MCL (Markov Clustering algorithm; <a href="https://dspace.library.uu.nl/handle/1874/848" target="_blank">Dongen 2000</a>;
            <a href="http://micans.org/mcl/" target="_blank">www.micans.org/mcl</a>) is invoked to split mega-clusters.
            This process is analogous to the manual review in COG construction.  MCL clustering is
            based on weights between each pair of proteins, so to correct for differences in
            evolutionary distance the weights are normalized before running MCL.
          </p>
          <p>
            OrthoMCL is similar to the INPARANOID algorithm (<a href="https://www.sciencedirect.com/science/article/abs/pii/S0022283600951970?via%3Dihub" target="_blank">Remm et al. 2001</a>), but is extended
            to cluster orthologs from multiple species. OrthoMCL clusters are coherent with groups
            identified by EGO (<a href="https://genome.cshlp.org/content/12/3/493.long" target="_blank">Lee et al. 2002</a>), and an analysis using EC number suggests a
            high degree of reliability (<a href="http://www.genome.org/cgi/content/abstract/13/9/2178" target="_blank">Li et al. 2003</a>).
          </p>
          <p>
            We evaluated the performance of seven widely-used orthology detection algorithms that use three general
	    prediction strategies: phylogeny-based, evolutionary distance-based and BLAST-based (<a href="http://www.plosone.org/article/info:doi%2F10.1371%2Fjournal.pone.0000383" target="_blank">Chen, et al. 2007</a>).
	    Specifically, we used Latent Class Analysis (LCA), a statistical technique appropriate for testing large data
	    sets when no gold standard is available. Our results show an overall trade-off between sensitivity and
	    specificity among these algorithms, with INPARANOID and OrthoMCL performing best with False Positive
            (FP) and False Negative (FN) error rates lower than 20%.
          </p>
        </div>
        <div id="faq" class="section-title">
          <h2>Frequently Asked Questions</h2>
        </div>
        <div class="section-content">
          <ol>
            <li>
              <span class="question">What is the difference between a Core group and a Residual group?</span>
              <p>
                <ul>
                  <li>A <b>Core</b> group is initially formed using all of the proteins from 150 Core species. As proteins from Peripheral species are added to the site, each protein is mapped to its most closely-related Core group. Thus, many Core groups contain proteins from Core and Peripheral species. These groups are stable across sub-releases (e.g., 6.1, 6.2, etc), though the groups may expand as Peripheral species are added to the site. The Core group names have the format OG6_xxxxxx.</li>
                  <li>A <b>Residual</b> group is formed at every sub-release (e.g., 6.1, 6.2, etc) using all of the proteins from Peripheral species that did not meet the thresholds necessary to map into a Core group. These groups contain proteins only from Peripheral species. The Residual group names have the format OG6r1_xxxxxx.</li>
                </ul>
              </p>
            </li>

            <li>
              <span class="question">What group information is provided?</span>
              <p>
                For each ortholog group, the following information and analyses are provided:
                <ul>
                  <li><b>Phyletic Distribution</b> The number of proteins from each species that belong to this ortholog group. The black box indicates presence (with the number below the genome abbreviation representing number of proteins) while the white box indicates absence.</li>
		  <li><b>Group Statistics</b>  A Core group may contain proteins from Core species only; in this case, statistics are provided for 'Core only'. Alternatively, a Core group may contain proteins from Core species as well as proteins from Peripheral species (that been mapped into the group); in this case, two sets of statistics are provided ('Core only' and 'Core+Peripheral'). A Residual group contains proteins from Peripheral species only; in this case, statistics are provided for 'Peripheral only'.</li>
                  <li><b>EC Number</b>  A list of all EC numbers assigned to the proteins in the group (Core and Peripheral proteins).</li>
                  <li><b>List of All Sequences</b>  The proteins in the group, along with their Core/Peripheral status and other useful information. All of the sequences can be downloaded by pressing the 'As Fasta file' or 'As new strategy' buttons.</li>
                  <li><b>PFam domains (graphic)</b>  The list of PFam domains in the group, along with a graphical representation of the domain within the context of each protein sequence. This representation is useful in comparing the overall structure of each protein and thus identify outliers (that are caused by evolution or sequencing/gene model errors).</li>
		  <li><b>PFam domains (details)</b>  The start and end location of each PFam domain within each protein sequence. In addition, this page offers a link-out to the PFam web page for each PFam domain.</li>
                  <li><b>MSA</b>  Multiple Sequence Alignment of the proteins within an ortholog group, using MUSCLE 3.8. For groups consisting of more than 100 protein sequences, 100 random proteins were chosen from the group for alignment. To align a different set of proteins from this group, we recommend downloading sequences (see 'List of All Sequences' above) and using the <a href="https://www.ebi.ac.uk/Tools/msa/muscle/" target="_blank">MUSCLE website</a> or your favorite MSA program.</li>
                  <li><b>Cluster graph</b>  Displays the sequence similarity between proteins in the group, using software first developed by Leon Goldovsky, EBI. This is useful in identifying a set of proteins that have diverged from the others, because this diverged set will cluster together in the graph. Graphs of 500 or more proteins cannot be created here; contact us at <a href="mailto:help@orthomcl.org" target="_blank">help@orthomcl.org</a> to request the Cluster layout data that can be used with other clustering software.</li>
                </ul>
              </p>
            </li>

            <li>
              <span class="question">How are the Group Statistics calculated?</span>
              <p>
		<ul>
                  <li><b>Avg % Match</b>  The % Match is calculated between two proteins by determining the percentage of the shorter protein sequence that is part of a High-scoring Segment Pair (HSP) with the other protein. The Avg % Match takes the average of all % Match results in the group.</li>
		  <li><b>Avg % Identity</b>  The % Identity is calculated between two proteins by determining the percentage of residues within the best High-scoring Segment Pair (HSP) that are identical. The Avg % Identity takes the average of all % Identity results in the group.</li>
		  <li><b>Num Pairs With Similarity</b>  The total number of protein pairs where the NCBI BLASTP E-Value is &lt; 1e-5 and the percent match length is &gt;= 50%.</li>
		  <li><b>Max Possible Pairs</b>  The maximum number of unique protein pairs that are possible in the group, equal to n*(n-1)/2, where n = number of proteins in the group.</li>
		  <li><b>% Protein Pairs With Similarity</b>  The percentage of proteins pairs where the two proteins are considered similar, equal to 100*actual/possible, where actual = Num Pairs With Similarity and possible = Max Possible Pairs.</li>
		  <li><b>Avg % Homology</b>  The percentage of all possible protein pairs where the two proteins are orthologs, co-orthologs, or inparalogs.</li>
		  <li><b>Avg Blast E-value</b>  The average Blast E-value for protein pairs, considering only pairs where the two proteins are considered similar (E-Value &lt; 1e-5 and percent match length &gt;= 50%).</li>
		</ul>
              </p>
            </li>

            <li>
              <span class="question">I recently sequenced a genome and want to use OrthoMCL to assign the proteins to ortholog groups. Can I do this?</span>
              <p>Yes. You can map your set of proteins to OrthoMCL Groups at the <a href="http://veupathdb.globusgenomics.org/" target="_blank">VEuPathDB Galaxy server</a>. To get started, visit our page: <a href="https://beta.orthomcl.org/orthomcl.beta/proteomeUpload.do" target="_blank">Map your proteins to OrthoMCL groups</a>
              </p>
            </li>

            <li>
              <span class="question">How can I find all <i>E. coli</i> genes (protein sequences) which have human orthologs?</span>
              <p>
                OrthoMCL-DB includes the <a href="http://code.google.com/p/strategies-wdk/" target="_blank">StrategiesWDK</a> system to allow you to form complex search strategies. In this case, several steps are required to find the answer:
                <ol>
                  <li>Find all ortholog groups that contain both human and <i>E. coli</i> sequences.  To do this, on the OrthoMCL home page select the "Phyletic Pattern" search under the "Identify Ortholog Groups" heading.  On that search's page, follow these steps</li>
                  <ol>
                    <li>Click once on the gray circle next to "ecol" and click once on the gray circle next to "hsap".  Clicking once will convert the gray circle into a green check mark indicating that the organism or phyletic group have been selected.</li>
                    <li>An alternative method for defining the phyletic pattern is to use an orthology phyletic pattern expression.  For this example the expression would be "ecol+hsap=2T".  Additional details describing phyletic pattern expressions are available on the search page.</li>
                    <li>Once you are satisfied with the selected parameters, click on the "Get Answer" button.  The search will return all OrthoMCL groups that contain both <i>E. coli</i> and human sequences.</li>
                  </ol>
                  <li>Retrieve the list of sequences contained in the identified groups.  Click on the "Add Step" button and select "Transform to Sequences" in the popup window, then click on "continue."  This transformation will return all sequences found in all the groups from the previous step.  This will include <i>E. coli</i> and human sequences in addition to all other sequences found in these groups.</li>
                  <li>Limit the list of results to those from <i>E. coli</i>. Click on the "Add Step" button and select "Taxonomy" under the "Search for Sequences by:" category in the popup window.</li>
                  <li>Type the taxon abbreviation for <i>E. coli</i> "ecol". Select the intersect operation for combining search results and click on 'Run Step".</li>
                </ol>
              </p>
            </li>
          </ol>
        </div>
        <div id="software" class="section-title">
          <h2>Software</h2>
        </div>
        <div class="section-content">
          <p>
            OrthoMCL was originally implemented by Li Li.  The software was not available for download.
          </p>
          <p>
            <a href="/common/downloads/software" target="_blank">Version 1.4</a> was developed as publicly available software by Feng Chen (This version is now not supported).
          </p>
          <p>
            <a href="/common/downloads/software" target="_blank">Version 2.0</a> was re-engineered to handle large-scale datasets (hundreds of genomes) by Steve Fischer, Mark Heiges, John Iodice, and Ryan Thibodeau
          </p>
        </div>
        <div id="pubs" class="section-title">
          <h2>Publications</h2>
        </div>
        <div class="section-content">
          <ol>
            <li>
              Li Li, Christian J. Stoeckert, Jr., and David S. Roos<br/>
              OrthoMCL: Identification of Ortholog Groups for Eukaryotic Genomes<br/>
              Genome Res. 2003 13: 2178-2189.
                <a href="http://www.genome.org/cgi/content/abstract/13/9/2178" target="_blank">[Abstract]</a>
                <a href="http://www.genome.org/cgi/content/full/13/9/2178" target="_blank">[Full Text]</a>
            </li>
            <li>
              Feng Chen, Aaron J. Mackey, Christian J. Stoeckert, Jr., and David S. Roos<br/>
              OrthoMCL-DB: querying a comprehensive multi-species collection of ortholog groups <br/>
              Nucleic Acids Res. 2006 34: D363-8.
                <a href="http://nar.oxfordjournals.org/cgi/content/full/34/suppl_1/D363" target="_blank">[Full Text]</a><br/>
                * Please cite this paper if you publish research results benefited from OrthoMCL-DB.
            </li>
            <li>
              Feng Chen, Aaron J. Mackey, Jeroen K. Vermunt, and David S. Roos <br/>
              Assessing Performance of Orthology Detection Strategies Applied to Eukaryotic Genomes<br/>
              PLoS ONE 2007 2(4): e383.
                <a href="http://www.plosone.org/article/info:doi%2F10.1371%2Fjournal.pone.0000383" target="_blank">[Full Text]</a><br/>
                * Recommended in <a href="http://www.f1000biology.com/article/id/1092076" target="_blank">Faculty1000</a>
            </li>
            <li>
            Fischer, S., Brunk, B. P., Chen, F., Gao, X., Harb, O. S., Iodice, J. B., Shanmugam, D., Roos, D. S. and Stoeckert, C. J.<br/>
            Using OrthoMCL to Assign Proteins to OrthoMCL-DB Groups or to Cluster Proteomes Into New Ortholog Groups<br/>
            Current Protocols in Bioinformatics. 2011 35:6.12.1–6.12.19.
              <a href="http://onlinelibrary.wiley.com/doi/10.1002/0471250953.bi0612s35/full" target="_blank">[Full Text]</a>
            </li>
          </ol>
        </div>
        <div id="acknowledge" class="section-title">
          <h2>Acknowledgements</h2>
        </div>
        <div class="section-content">
          <p>
            This project has been funded in whole or in part with Federal funds from the National
            Institute of Allergy and Infectious Diseseases, National Institutes of Health, Department
            of Health and Human Services, under Contract No. HHSN266200400037C. The major PIs are
            Drs. David Roos and Chris Stoeckert.
          </p>
          <p>
            The OrthoMCL-DB project was initiated by Feng Chen in April 2005, and people from
            VEuPathDB, PCBI, and the Penn Center for Bioinformatics who have contributed to the
	    project include: Mark Hickman, Steve Fischer, Brian Brunk, Omar Harb, Ryan Doherty,
	    Aaron Mackey, Praveen Chakravarthula, Jerric Gao, and Charles Treatman. We'd also
	    like to thank students and postdocs from the Roos lab for valuable suggestions,
	    specifically Lucia Peixoto, and Dhanasekaran Shanmugam.
          </p>
        </div>
        <div id="contact" class="section-title">
          <h2>Contact</h2>
        </div>
        <div class="section-content">
          <p>
            Feel free to contact us with comments or questions by filling out the
            <a href="${pageContext.request.contextPath}/contact.do" class="open-window-contact-us">Contact Us</a>
            form, or emailing us at <a href="mailto:help@orthomcl.org" target="_blank">help@orthomcl.org</a>.
          </p>
        </div>
      </div>
    </div>

  </imp:pageFrame>
</jsp:root>
