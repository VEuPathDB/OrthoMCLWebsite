package org.orthomcl.model;

public class GenePair {

  private final String queryId;
  private final String subjectId;

  public GenePair(String queryId, String subjectId) {
    this.queryId = queryId;
    this.subjectId = subjectId;
  }
  
  /**
   * @return the queryId
   */
  public String getQueryId() {
    return queryId;
  }



  /**
   * @return the subjectId
   */
  public String getSubjectId() {
    return subjectId;
  }



  @Override
  public int hashCode() {
    return queryId.hashCode() ^ subjectId.hashCode();
  }

  @Override
  public boolean equals(Object obj) {
    if (obj instanceof GenePair) {
      GenePair pair = (GenePair) obj;
      return (pair.queryId.equals(queryId) && pair.subjectId.equals(subjectId));
    }
    else {
      return false;
    }
  }
}
