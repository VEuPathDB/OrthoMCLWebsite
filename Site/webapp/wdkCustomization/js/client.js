import 'eupathdb/wdkCustomization/css/client.css';
import { initialize } from 'eupathdb/wdkCustomization/js/client/bootstrap';

const quickSearches = [
  { name: 'groups-by-text-search', quickSearchParamName: 'text_expression', quickSearchDisplayName: 'Groups Quick Search' },
  { name: 'ByTextSearch', quickSearchParamName: 'text_expression', quickSearchDisplayName: 'Sequences Quick Search' }
]

initialize({
  quickSearches
});
