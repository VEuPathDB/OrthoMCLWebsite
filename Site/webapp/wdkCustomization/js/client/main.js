import 'eupathdb/wdkCustomization/css/client.css';
import { initialize } from 'eupathdb/wdkCustomization/js/client/bootstrap';
import mainMenuItems from './mainMenuItems';
import smallMenuItems from './smallMenuItems';

const quickSearches = [
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
]

initialize({
  mainMenuItems,
  smallMenuItems,
  quickSearches
});
