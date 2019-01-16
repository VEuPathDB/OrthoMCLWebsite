import React from 'react';
import ClassicSiteHeader from 'ebrc-client/components/ClassicSiteHeader';

import makeMainMenuItems from '../mainMenuItems';
import makeSmallMenuItems from '../smallMenuItems';

const quickSearchReferences = [
  {
    name: 'GroupQuestions.ByTextSearch',
    paramName: 'text_expression',
    displayName: 'Groups Quick Search',
    help: `Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on 'Groups Quick Search' to access the advanced group search page.`
  },
  {
    name: 'SequenceQuestions.ByTextSearch',
    paramName: 'text_expression',
    displayName: 'Sequences Quick Search',
    help: `Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on 'Sequences Quick Search' to access the advanced sequence search page.`
  }
];

export default function SiteHeader() {
  return (
    <ClassicSiteHeader
      includeQueryGrid={false}
      makeMainMenuItems={makeMainMenuItems}
      makeSmallMenuItems={makeSmallMenuItems}
      quickSearchReferences={quickSearchReferences}
    />
  )
}