/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 66);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

module.exports = _;

/***/ }),
/* 1 */
/***/ (function(module, exports) {

module.exports = React;

/***/ }),
/* 2 */
/***/ (function(module, exports) {

module.exports = Wdk.Components;

/***/ }),
/* 3 */
/***/ (function(module, exports) {

module.exports = Wdk;

/***/ }),
/* 4 */
/***/ (function(module, exports) {

module.exports = Wdk.ComponentUtils;

/***/ }),
/* 5 */
/***/ (function(module, exports) {

module.exports = ReactPropTypes;

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(global) {/*global window, global*/
var util = __webpack_require__(55)
var assert = __webpack_require__(72)
var now = __webpack_require__(73)

var slice = Array.prototype.slice
var console
var times = {}

if (typeof global !== "undefined" && global.console) {
    console = global.console
} else if (typeof window !== "undefined" && window.console) {
    console = window.console
} else {
    console = {}
}

var functions = [
    [log, "log"],
    [info, "info"],
    [warn, "warn"],
    [error, "error"],
    [time, "time"],
    [timeEnd, "timeEnd"],
    [trace, "trace"],
    [dir, "dir"],
    [consoleAssert, "assert"]
]

for (var i = 0; i < functions.length; i++) {
    var tuple = functions[i]
    var f = tuple[0]
    var name = tuple[1]

    if (!console[name]) {
        console[name] = f
    }
}

module.exports = console

function log() {}

function info() {
    console.log.apply(console, arguments)
}

function warn() {
    console.log.apply(console, arguments)
}

function error() {
    console.warn.apply(console, arguments)
}

function time(label) {
    times[label] = now()
}

function timeEnd(label) {
    var time = times[label]
    if (!time) {
        throw new Error("No such label: " + label)
    }

    var duration = now() - time
    console.log(label + ": " + duration + "ms")
}

function trace() {
    var err = new Error()
    err.name = "Trace"
    err.message = util.format.apply(null, arguments)
    console.error(err.stack)
}

function dir(object) {
    console.log(util.inspect(object) + "\n")
}

function consoleAssert(expression) {
    if (!expression) {
        var arr = slice.call(arguments, 1)
        assert.ok(false, util.format.apply(null, arr))
    }
}

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(20)))

/***/ }),
/* 7 */
/***/ (function(module, exports) {



/***/ }),
/* 8 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });

var ExcelNote = function ExcelNote(props) {
  return React.createElement(
    "span",
    null,
    "* If you choose \"Excel File\" as Download Type, you can only download a maximum 10M (in bytes) of the results and the rest will be discarded.",
    React.createElement("br", null),
    "Opening a huge Excel file may crash your system. If you need to get the complete results, please choose \"Text File\"."
  );
};

/* harmony default export */ __webpack_exports__["default"] = (ExcelNote);

/***/ }),
/* 9 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);


var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["OntologyUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["CategoryUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    CategoriesCheckboxTree = _Wdk$Components.CategoriesCheckboxTree,
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox,
    ReporterSortMessage = _Wdk$Components.ReporterSortMessage;


var SharedReporterForm = function SharedReporterForm(props) {
  var scope = props.scope,
      question = props.question,
      recordClass = props.recordClass,
      formState = props.formState,
      formUiState = props.formUiState,
      updateFormState = props.updateFormState,
      updateFormUiState = props.updateFormUiState,
      onSubmit = props.onSubmit,
      ontology = props.globalData.ontology;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  var getUiUpdateHandler = function getUiUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormUiState, formUiState);
  };

  return React.createElement(
    "div",
    null,
    React.createElement(
      "div",
      { className: "eupathdb-ReporterForm eupathdb-ReporterForm__shared" },
      React.createElement(ReporterSortMessage, { scope: scope }),
      React.createElement(
        "div",
        { className: "eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__columns" },
        React.createElement(CategoriesCheckboxTree
        // title and layout of the tree
        , { title: "Choose Attributes",
          searchBoxPlaceholder: "Search Attributes...",
          tree: util.getAttributeTree(ontology, recordClass.name, question)

          // state of the tree
          , selectedLeaves: formState.attributes,
          expandedBranches: formUiState.expandedAttributeNodes,
          searchTerm: formUiState.attributeSearchText

          // change handlers for each state element controlled by the tree
          , onChange: util.getAttributesChangeHandler('attributes', updateFormState, formState, recordClass),
          onUiChange: getUiUpdateHandler('expandedAttributeNodes'),
          onSearchTermChange: getUiUpdateHandler('attributeSearchText')
        })
      ),
      React.createElement(
        "div",
        { className: "eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__tables" },
        React.createElement(CategoriesCheckboxTree
        // title and layout of the tree
        , { title: "Choose Tables",
          searchBoxPlaceholder: "Search Tables...",
          tree: util.getTableTree(ontology, recordClass.name)

          // state of the tree
          , selectedLeaves: formState.tables,
          expandedBranches: formUiState.expandedTableNodes,
          searchTerm: formUiState.tableSearchText

          // change handlers for each state element controlled by the tree
          , onChange: getUpdateHandler('tables'),
          onUiChange: getUiUpdateHandler('expandedTableNodes'),
          onSearchTermChange: getUiUpdateHandler('tableSearchText')
        })
      ),
      React.createElement(
        "div",
        { className: "eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__otherOptions" },
        React.createElement(
          "div",
          { className: "eupathdb-ReporterFormDownloadType" },
          React.createElement(
            "h3",
            null,
            "Download Type"
          ),
          React.createElement(
            "div",
            null,
            React.createElement(RadioList, { name: "attachmentType", value: formState.attachmentType,
              onChange: getUpdateHandler('attachmentType'), items: util.attachmentTypes })
          )
        ),
        React.createElement(
          "div",
          { className: "eupathdb-ReporterFormAddtionOptions" },
          React.createElement(
            "h3",
            null,
            "Additional Options"
          ),
          React.createElement(
            "div",
            null,
            React.createElement(
              "label",
              null,
              React.createElement(Checkbox, { value: formState.includeEmptyTables, onChange: getUpdateHandler('includeEmptyTables') }),
              React.createElement(
                "span",
                { style: { marginLeft: '0.5em' } },
                "Include empty tables"
              )
            )
          )
        )
      )
    ),
    React.createElement(
      "div",
      { className: "eupathdb-ReporterFormSubmit" },
      React.createElement(
        "button",
        { className: "btn", type: "submit", onClick: onSubmit },
        "Get ",
        recordClass.displayNamePlural
      )
    )
  );
};

SharedReporterForm.getInitialState = function (downloadFormStoreState) {
  var scope = downloadFormStoreState.scope,
      question = downloadFormStoreState.question,
      recordClass = downloadFormStoreState.recordClass,
      _downloadFormStoreSta = downloadFormStoreState.globalData,
      ontology = _downloadFormStoreSta.ontology,
      preferences = _downloadFormStoreSta.preferences;
  // select all attribs and tables for record page, else column user prefs and no tables

  var allReportScopedAttrs = util.getAllLeafIds(util.getAttributeTree(ontology, recordClass.name, question));
  var attribs = util.addPk(scope === 'results' ? util.getAttributeSelections(preferences, question, allReportScopedAttrs) : allReportScopedAttrs, recordClass);
  var tables = scope === 'results' ? [] : util.getAllLeafIds(util.getTableTree(ontology, recordClass.name));
  return {
    formState: {
      attributes: attribs,
      tables: tables,
      includeEmptyTables: true,
      attachmentType: "plain"
    },
    formUiState: {
      expandedAttributeNodes: null,
      attributeSearchText: "",
      expandedTableNodes: null,
      tableSearchText: ""
    }
  };
};

/* harmony default export */ __webpack_exports__["default"] = (SharedReporterForm);

/***/ }),
/* 10 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = SrtHelp;
function SrtHelp() {
  return React.createElement(
    "div",
    null,
    React.createElement("img", { src: "/a/images/genemodel.gif" }),
    React.createElement("br", null),
    "Types of sequences:",
    React.createElement(
      "table",
      { width: "100%", cellPadding: "4" },
      React.createElement(
        "tbody",
        null,
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "protein"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "the predicted translation of the gene"
          )
        ),
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "CDS"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "the coding sequence, excluding UTRs (introns spliced out)"
          )
        ),
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "transcript"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "the processed transcript, including UTRs (introns spliced out)"
          )
        ),
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "genomic"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "a region of the genome.  ",
            React.createElement(
              "i",
              null,
              "Genomic sequence is always returned from 5' to 3', on the proper strand"
            )
          )
        )
      )
    ),
    React.createElement("br", null),
    "Regions:",
    React.createElement(
      "table",
      { width: "100%", cellPadding: "4" },
      React.createElement(
        "tbody",
        null,
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "relative to sequence start"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "to retrieve, eg, the 100 bp upstream genomic region, use \"begin at ",
            React.createElement(
              "i",
              null,
              "start"
            ),
            " - 100  end at ",
            React.createElement(
              "i",
              null,
              "start"
            ),
            " - 1\"."
          )
        ),
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "relative to sequence stop"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "to retrieve, eg, the last 10 bp of a sequence, use \"begin at ",
            React.createElement(
              "i",
              null,
              "stop"
            ),
            " - 9  end at ",
            React.createElement(
              "i",
              null,
              "stop"
            ),
            " + 0\"."
          )
        ),
        React.createElement(
          "tr",
          null,
          React.createElement(
            "td",
            null,
            React.createElement(
              "i",
              null,
              React.createElement(
                "b",
                null,
                "relative to sequence start and stop"
              )
            )
          ),
          React.createElement(
            "td",
            null,
            "to retrieve, eg, a CDS with the  first and last 10 basepairs excised, use: \"begin at ",
            React.createElement(
              "i",
              null,
              "start"
            ),
            " + 10 end at ",
            React.createElement(
              "i",
              null,
              "stop"
            ),
            " - 10\"."
          )
        )
      )
    ),
    React.createElement("br", null),
    "Note:  If UTRs have not been annotated for a gene, then choosing \"transcription start\" may have the same effect as choosing \"translation start.\"",
    React.createElement(
      "table",
      null,
      React.createElement(
        "tbody",
        null,
        React.createElement(
          "tr",
          null,
          React.createElement("td", { valign: "top", className: "dottedLeftBorder" })
        )
      )
    )
  );
}

/***/ }),
/* 11 */
/***/ (function(module, exports, __webpack_require__) {

var re = /\.(js|jsx|ts|tsx)$/;
var req = __webpack_require__(92);
Object.defineProperty(exports, '__esModule', { value: true });

var _iteratorNormalCompletion = true;
var _didIteratorError = false;
var _iteratorError = undefined;

try {
  for (var _iterator = req.keys()[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
    var key = _step.value;

    if (key === './' || key === './index' || re.test(key)) continue;
    exports[key.replace(/([^/]*\/)*/, '')] = req(key).default;
  }
} catch (err) {
  _didIteratorError = true;
  _iteratorError = err;
} finally {
  try {
    if (!_iteratorNormalCompletion && _iterator.return) {
      _iterator.return();
    }
  } finally {
    if (_didIteratorError) {
      throw _iteratorError;
    }
  }
}

/***/ }),
/* 12 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ExcelNote__ = __webpack_require__(8);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["CategoryUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    CategoriesCheckboxTree = _Wdk$Components.CategoriesCheckboxTree,
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox,
    ReporterSortMessage = _Wdk$Components.ReporterSortMessage;


var TableReporterForm = function TableReporterForm(props) {
  var scope = props.scope,
      question = props.question,
      recordClass = props.recordClass,
      formState = props.formState,
      formUiState = props.formUiState,
      updateFormState = props.updateFormState,
      updateFormUiState = props.updateFormUiState,
      onSubmit = props.onSubmit,
      ontology = props.globalData.ontology;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  var getUiUpdateHandler = function getUiUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormUiState, formUiState);
  };

  return React.createElement(
    'div',
    null,
    React.createElement(ReporterSortMessage, { scope: scope }),
    React.createElement(
      'div',
      { className: 'eupathdb-ReporterForm' },
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__tables' },
        React.createElement(CategoriesCheckboxTree
        // title and layout of the tree
        , { title: 'Choose a Table',
          searchBoxPlaceholder: 'Search Tables...',
          tree: util.getTableTree(ontology, recordClass.name, question)

          // state of the tree
          , selectedLeaves: formState.tables,
          expandedBranches: formUiState.expandedTableNodes,
          searchTerm: formUiState.tableSearchText,
          isMultiPick: false

          // change handlers for each state element controlled by the tree
          , onChange: getUpdateHandler('tables'),
          onUiChange: getUiUpdateHandler('expandedTableNodes'),
          onSearchTermChange: getUiUpdateHandler('tableSearchText')
        })
      ),
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__otherOptions' },
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Download Type'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(RadioList, { value: formState.attachmentType, items: util.tabularAttachmentTypes,
              onChange: getUpdateHandler('attachmentType') })
          )
        ),
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Additional Options'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(
              'label',
              null,
              React.createElement(Checkbox, { value: formState.includeHeader, onChange: getUpdateHandler('includeHeader') }),
              React.createElement(
                'span',
                { style: { marginLeft: '0.5em' } },
                'Include header row (column names)'
              )
            )
          )
        )
      )
    ),
    React.createElement(
      'div',
      { className: 'eupathdb-ReporterFormSubmit' },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Get ',
        recordClass.displayNamePlural
      )
    ),
    React.createElement('hr', null),
    React.createElement(
      'div',
      { style: { margin: '0.5em 2em' } },
      React.createElement(__WEBPACK_IMPORTED_MODULE_1__ExcelNote__["default"], null)
    ),
    React.createElement('hr', null)
  );
};

TableReporterForm.getInitialState = function (downloadFormStoreState) {
  var tableTree = util.getTableTree(downloadFormStoreState.globalData.ontology, downloadFormStoreState.recordClass.name, downloadFormStoreState.question);
  var firstLeafName = util.findFirstLeafId(tableTree);
  return {
    formState: {
      tables: [firstLeafName],
      includeHeader: true,
      attachmentType: "plain"
    },
    formUiState: {
      expandedTableNodes: null,
      tableSearchText: ""
    }
  };
};

/* harmony default export */ __webpack_exports__["default"] = (TableReporterForm);

/***/ }),
/* 13 */
/***/ (function(module, exports) {

module.exports = Wdk.IterableUtils;

/***/ }),
/* 14 */
/***/ (function(module, exports, __webpack_require__) {

var re = /\.(js|jsx|ts|tsx)$/;
var req = __webpack_require__(90);
Object.defineProperty(exports, '__esModule', { value: true });

var _iteratorNormalCompletion = true;
var _didIteratorError = false;
var _iteratorError = undefined;

try {
  for (var _iterator = req.keys()[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
    var key = _step.value;

    if (key === './' || key === './index' || re.test(key)) continue;
    exports[key.replace(/([^/]*\/)*/, '')] = req(key).default;
  }
} catch (err) {
  _didIteratorError = true;
  _iteratorError = err;
} finally {
  try {
    if (!_iteratorNormalCompletion && _iterator.return) {
      _iterator.return();
    }
  } finally {
    if (_didIteratorError) {
      throw _iteratorError;
    }
  }
}

/***/ }),
/* 15 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "propTypes", function() { return propTypes; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__ActiveGroup__ = __webpack_require__(41);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_wdk_client_FilterServiceUtils__ = __webpack_require__(59);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_wdk_client_FilterServiceUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_wdk_client_FilterServiceUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_6_wdk_client_ComponentUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__ = __webpack_require__(13);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__util_classNames__ = __webpack_require__(42);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__ = __webpack_require__(43);
var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }












/**
 * QuestionWizard component
 */
function QuestionWizard(props) {
  var _props$wizardState = props.wizardState,
      question = _props$wizardState.question,
      paramValues = _props$wizardState.paramValues,
      activeGroup = _props$wizardState.activeGroup;


  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    'div',
    { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])() + ' show-scrollbar' },
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'div',
      { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('HeadingContainer') },
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'h1',
        { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('Heading') },
        question.displayName,
        ' \xA0',
        question.groups.some(function (groupName) {
          return !Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["e" /* groupParamsValuesAreDefault */])(props.wizardState, groupName);
        }) && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'button',
          {
            type: 'button',
            title: 'View a summary of active filters',
            className: 'wdk-Link',
            onClick: function onClick() {
              return props.eventHandlers.setFilterPopupVisiblity(!props.wizardState.filterPopupState.visible);
            }
          },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'filter', className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('GroupFilterIcon') })
        )
      ),
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(FilterSummary, props)
    ),
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(Navigation, props),
    activeGroup == null ? __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'div',
      { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupContainer') },
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'p',
        { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('HelpText') },
        question.summary
      )
    ) : __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_3__ActiveGroup__["default"], props),
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('input', { type: 'hidden', name: 'questionFullName', value: question.name }),
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('input', { type: 'hidden', name: 'questionSubmit', value: 'Get Answer' }),
    question.parameters.map(function (param) {
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('input', { key: param.name, type: 'hidden', name: 'value(' + param.name + ')', value: paramValues[param.name] });
    })
  );
}

var wizardPropTypes = {
  question: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  paramValues: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  paramUIState: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  groupUIState: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  recordClass: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  activeGroup: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  initialCount: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.number
};

var eventHandlerPropTypes = {
  setActiveGroup: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setActiveOntologyTerm: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setOntologyTermSort: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setOntologyTermSearch: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setParamValue: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  updateInvalidGroupCounts: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setFilterPopupVisiblity: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  setFilterPopupPinned: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired
};

var propTypes = QuestionWizard.propTypes = {
  customName: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  isAddingStep: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool.isRequired,
  showHelpText: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool.isRequired,
  wizardState: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.shape(wizardPropTypes).isRequired,
  eventHandlers: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.shape(eventHandlerPropTypes)
};

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_6_wdk_client_ComponentUtils__["wrappable"])(QuestionWizard));

/**
 * GroupList component
 */
function Navigation(props) {
  var _props$wizardState2 = props.wizardState,
      activeGroup = _props$wizardState2.activeGroup,
      question = _props$wizardState2.question,
      groupUIState = _props$wizardState2.groupUIState,
      recordClass = _props$wizardState2.recordClass,
      initialCount = _props$wizardState2.initialCount,
      _props$eventHandlers = props.eventHandlers,
      setActiveGroup = _props$eventHandlers.setActiveGroup,
      updateInvalidGroupCounts = _props$eventHandlers.updateInvalidGroupCounts,
      setFilterPopupVisiblity = _props$eventHandlers.setFilterPopupVisiblity,
      customName = props.customName,
      showHelpText = props.showHelpText,
      isAddingStep = props.isAddingStep;
  var groups = question.groups;

  var invalid = Object.values(groupUIState).some(function (uiState) {
    return uiState.valid === false && uiState.loading !== true;
  });

  var finalCountState = __WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__["Seq"].of({ accumulatedTotal: initialCount }).concat(__WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__["Seq"].from(groups).map(function (group) {
    return groupUIState[group.name];
  }).filter(function (groupState) {
    return groupState.valid !== undefined;
  })).last();

  // A Map from a group to its previous group
  var prevGroupMap = new Map(Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["zip"])(groups.slice(1), groups.slice(0, -1)));

  // XXX We should probably have a separate component for RecordClassIcon to encapsulate this logic
  var iconName = recordClass.iconName || 'database';

  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    __WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["Sticky"],
    null,
    function (_ref) {
      var isFixed = _ref.isFixed;
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('NavigationContainer', isFixed && 'fixed') },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('NavigationIconContainer') },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'button',
            {
              type: 'button',
              title: 'See search overview',
              className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('IconButton'),
              onClick: function onClick() {
                return setActiveGroup(null);
              }
            },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: iconName, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('Icon') })
          )
        ),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupSeparator') },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('div', { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupArrow') }),
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(ParamGroupCount, {
            title: 'All ' + recordClass.displayNamePlural,
            count: initialCount,
            isActive: activeGroup == groups[0]
          })
        ),
        __WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__["Seq"].from(groups).flatMap(function (group) {
          return [__WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'div',
            {
              key: group.name,
              className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroup', group === activeGroup && 'active')
            },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'button',
              {
                type: 'button',
                title: 'Filter ' + recordClass.displayNamePlural + ' by ' + group.displayName,
                className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupButton', group == activeGroup && 'active'),
                onClick: function onClick() {
                  return setActiveGroup(group);
                }
              },
              group.displayName
            ),
            Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["e" /* groupParamsValuesAreDefault */])(props.wizardState, group) || __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'button',
              {
                type: 'button',
                title: 'View a summary of active filters',
                className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('GroupFilterIconButton') + ' wdk-Link',
                onClick: function onClick() {
                  return setFilterPopupVisiblity(!props.wizardState.filterPopupState.visible);
                }
              },
              __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], {
                fa: 'filter',
                className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('GroupFilterIcon')
              })
            ),
            showHelpText && activeGroup == null && group === groups[0] && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'div',
              { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('GetStarted') },
              'Click to get started. ',
              __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
                'em',
                null,
                '(skipping ahead is ok)'
              )
            )
          ), group !== groups[groups.length - 1] && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'div',
            { key: group.name + '__sep', className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupSeparator') },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('div', { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupArrow') }),
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(ParamGroupCount, {
              title: recordClass.displayNamePlural + ' selected from previous steps.',
              count: groupUIState[group.name].accumulatedTotal,
              isLoading: groupUIState[group.name].loading,
              isValid: groupUIState[group.name].valid,
              isActive: group === activeGroup || group === prevGroupMap.get(activeGroup)
            })
          )];
        }),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('SubmitContainer') },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'button',
            {
              className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('SubmitButton'),
              title: 'View the results of your search for further analysis.'
            },
            finalCountState.accumulatedTotal == null || finalCountState.loading ? __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["Loading"], { radius: 4, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupCountLoading') }) : finalCountState.valid === false ? 'View ? ' + recordClass.displayNamePlural : (isAddingStep ? 'Combine' : 'View') + ' ' + Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["result"])(finalCountState.accumulatedTotal, 'toLocaleString') + ' ' + recordClass.displayNamePlural
          ),
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('input', { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('CustomNameInput'), defaultValue: customName, type: 'text', name: 'customName', placeholder: 'Name this search' })
        ),
        invalid && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('InvalidCounts') },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'button',
            {
              type: 'button',
              className: 'wdk-Link',
              onClick: updateInvalidGroupCounts,
              title: 'Recompute invalid counts above'
            },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'refresh' }),
            ' Refresh counts'
          )
        )
      );
    }
  );
}

Navigation.propTypes = QuestionWizard.propTypes;

/** Render count or loading */
function ParamGroupCount(props) {
  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    'div',
    { title: props.title,
      className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupCount', props.isValid === false && 'invalid', props.isActive && 'active')
    },
    props.isLoading === true ? __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["Loading"], { radius: 2, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamGroupCountLoading') }) : props.isValid === false ? '?' : Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["result"])(props.count, 'toLocaleString')
  );
}

ParamGroupCount.propTypes = {
  title: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string,
  count: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.number,
  isValid: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  isLoading: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  isActive: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool
};

/**
 * Show a summary of active filters
 */

var FilterSummary = function (_React$Component) {
  _inherits(FilterSummary, _React$Component);

  function FilterSummary() {
    _classCallCheck(this, FilterSummary);

    return _possibleConstructorReturn(this, (FilterSummary.__proto__ || Object.getPrototypeOf(FilterSummary)).apply(this, arguments));
  }

  _createClass(FilterSummary, [{
    key: 'render',
    value: function render() {
      var _React$createElement;

      var _props = this.props,
          wizardState = _props.wizardState,
          eventHandlers = _props.eventHandlers;


      var filterSummary = __WEBPACK_IMPORTED_MODULE_7_wdk_client_IterableUtils__["Seq"].from(wizardState.question.groups).filter(function (group) {
        return !Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["e" /* groupParamsValuesAreDefault */])(wizardState, group);
      }).map(function (group) {
        return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { key: group.name, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterSummaryGroup') },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'h4',
            null,
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'filter', className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('GroupFilterIcon') }),
            ' ',
            group.displayName
          ),
          Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["e" /* groupParamsValuesAreDefault */])(wizardState, group) ? __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'em',
            null,
            'No filters applied'
          ) : Object.entries(Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["d" /* getParameterValuesForGroup */])(wizardState, group.name)).filter(function (_ref2) {
            var _ref3 = _slicedToArray(_ref2, 2),
                paramName = _ref3[0],
                paramValue = _ref3[1];

            return Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["c" /* getParameter */])(wizardState, paramName).defaultValue !== paramValue;
          }).map(function (_ref4) {
            var _ref5 = _slicedToArray(_ref4, 2),
                paramName = _ref5[0],
                paramValue = _ref5[1];

            return getParamSummaryElements({
              group: group,
              paramValue: paramValue,
              wizardState: wizardState,
              eventHandlers: eventHandlers,
              parameter: Object(__WEBPACK_IMPORTED_MODULE_9__util_QuestionWizardState__["c" /* getParameter */])(wizardState, paramName)
            });
          })
        );
      });

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        __WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["Dialog"],
        (_React$createElement = {
          resizable: true,
          draggable: true,
          className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterSummary'),
          open: wizardState.filterPopupState.visible,
          title: 'Active Filters'
        }, _defineProperty(_React$createElement, 'className', Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterSummary')), _defineProperty(_React$createElement, 'buttons', [__WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'button',
          {
            key: 'pin',
            type: 'button',
            title: 'Prevent summary popup from closing when clicking on filters.',
            className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterPopupTitleButton'),
            onClick: function onClick() {
              return eventHandlers.setFilterPopupPinned(!wizardState.filterPopupState.pinned);
            }
          },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: wizardState.filterPopupState.pinned ? 'circle' : 'thumb-tack' })
        ), __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'button',
          {
            type: 'button',
            key: 'close',
            className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterPopupTitleButton'),
            onClick: function onClick() {
              return eventHandlers.setFilterPopupVisiblity(false);
            }
          },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'close' })
        )]), _React$createElement),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          null,
          filterSummary.isEmpty() ? __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'p',
            null,
            'No filters applied'
          ) : filterSummary,
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'div',
            { className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('FilterSummaryRemoveAll') },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'button',
              { type: 'button', className: 'wdk-Link', onClick: function onClick() {
                  return eventHandlers.resetParamValues();
                } },
              'Remove all'
            )
          )
        )
      );
    }
  }]);

  return FilterSummary;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.Component);

FilterSummary.propTypes = propTypes;

function getParamSummaryElements(data) {
  return data.parameter.type === 'FilterParamNew' ? getFilterParamSummaryElements(data) : [__WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    'div',
    { key: data.parameter.name, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('Chicklet') },
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'a',
      {
        href: '#' + data.parameter.name,
        onClick: function onClick(e) {
          e.preventDefault();
          data.eventHandlers.setActiveGroup(data.group);
          if (!data.wizardState.filterPopupState.pinned) {
            data.eventHandlers.setFilterPopupVisiblity(false);
          }
        }
      },
      data.parameter.displayName
    ),
    '\xA0',
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'button',
      {
        type: 'button',
        className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('RemoveFilterButton'),
        onClick: function onClick() {
          return data.eventHandlers.setParamValue(data.parameter, data.parameter.defaultValue);
        }
      },
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'close' })
    ),
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('hr', null),
    __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'small',
      null,
      prettyPrint(data.parameter, data.paramValue)
    )
  )];
}

function getFilterParamSummaryElements(data) {
  var _JSON$parse = JSON.parse(data.paramValue),
      filters = _JSON$parse.filters;

  if (filters == null) return null;

  return filters.map(function (filter) {
    var field = data.parameter.ontology.find(function (field) {
      return field.term === filter.field;
    });
    return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'div',
      { key: data.parameter.name + '::' + field.term, className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('Chicklet') },
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'a',
        {
          href: '#' + field.term,
          onClick: function onClick(e) {
            e.preventDefault();
            data.eventHandlers.setActiveGroup(data.group);
            data.eventHandlers.setActiveOntologyTerm(data.parameter, filters, field.term);
            if (!data.wizardState.filterPopupState.pinned) {
              data.eventHandlers.setFilterPopupVisiblity(false);
            }
          }
        },
        field.display
      ),
      '\xA0',
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'button',
        {
          type: 'button',
          className: Object(__WEBPACK_IMPORTED_MODULE_8__util_classNames__["a" /* makeQuestionWizardClassName */])('RemoveFilterButton'),
          onClick: function onClick() {
            return data.eventHandlers.setParamValue(data.parameter, JSON.stringify({
              filters: filters.filter(function (f) {
                return f !== filter;
              })
            }));
          }
        },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5_wdk_client_Components__["IconAlt"], { fa: 'close' })
      ),
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('hr', null),
      __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'small',
        null,
        Object(__WEBPACK_IMPORTED_MODULE_4_wdk_client_FilterServiceUtils__["getFilterValueDisplay"])(field, filter)
      )
    );
  });
}

function prettyPrint(param, value) {
  switch (param.type) {
    case 'DateRangeParam':
    case 'NumberRangeParam':
      return prettyPrintRange(JSON.parse(value));
    default:
      return value;
  }
}

function prettyPrintRange(range) {
  return 'between ' + range.min + ' and ' + range.max;
}

/***/ }),
/* 16 */
/***/ (function(module, exports) {

module.exports = Wdk.Controllers;

/***/ }),
/* 17 */
/***/ (function(module, exports) {

module.exports = Wdk.CategoryUtils;

/***/ }),
/* 18 */
/***/ (function(module, exports) {

module.exports = Wdk.TreeUtils;

/***/ }),
/* 19 */
/***/ (function(module, exports) {

module.exports = ReactDOM;

/***/ }),
/* 20 */
/***/ (function(module, exports) {

var g;

// This works in non-strict mode
g = (function() {
	return this;
})();

try {
	// This works if eval is allowed (see CSP)
	g = g || Function("return this")() || (1,eval)("this");
} catch(e) {
	// This works if the window reference is available
	if(typeof window === "object")
		g = window;
}

// g can still be undefined, but nothing to do about it...
// We return undefined, instead of nothing here, so it's
// easier to handle this case. if(!global) { ...}

module.exports = g;


/***/ }),
/* 21 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "rootUrl", function() { return rootUrl; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "rootElement", function() { return rootElement; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "displayName", function() { return displayName; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "endpoint", function() { return endpoint; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "projectId", function() { return projectId; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "buildNumber", function() { return buildNumber; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "releaseDate", function() { return releaseDate; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "webAppUrl", function() { return webAppUrl; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "facebookUrl", function() { return facebookUrl; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "twitterUrl", function() { return twitterUrl; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "youtubeUrl", function() { return youtubeUrl; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "recordClassesWithProjectId", function() { return recordClassesWithProjectId; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "announcements", function() { return announcements; });
// __SITE_CONFIG__ is defined in index.jsp
var _window$__SITE_CONFIG = window.__SITE_CONFIG__,
    rootUrl = _window$__SITE_CONFIG.rootUrl,
    rootElement = _window$__SITE_CONFIG.rootElement,
    displayName = _window$__SITE_CONFIG.displayName,
    endpoint = _window$__SITE_CONFIG.endpoint,
    projectId = _window$__SITE_CONFIG.projectId,
    buildNumber = _window$__SITE_CONFIG.buildNumber,
    releaseDate = _window$__SITE_CONFIG.releaseDate,
    webAppUrl = _window$__SITE_CONFIG.webAppUrl,
    facebookUrl = _window$__SITE_CONFIG.facebookUrl,
    twitterUrl = _window$__SITE_CONFIG.twitterUrl,
    youtubeUrl = _window$__SITE_CONFIG.youtubeUrl,
    recordClassesWithProjectId = _window$__SITE_CONFIG.recordClassesWithProjectId;

// __SITE_ANNOUNCEMENTS__ is defined in index.jsp


var announcements = window.__SITE_ANNOUNCEMENTS__;

/***/ }),
/* 22 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ExcelNote__ = __webpack_require__(8);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["CategoryUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    CategoriesCheckboxTree = _Wdk$Components.CategoriesCheckboxTree,
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox,
    ReporterSortMessage = _Wdk$Components.ReporterSortMessage;


var TabularReporterForm = function TabularReporterForm(props) {
  var scope = props.scope,
      question = props.question,
      recordClass = props.recordClass,
      formState = props.formState,
      formUiState = props.formUiState,
      updateFormState = props.updateFormState,
      updateFormUiState = props.updateFormUiState,
      onSubmit = props.onSubmit,
      ontology = props.globalData.ontology;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  var getUiUpdateHandler = function getUiUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormUiState, formUiState);
  };

  return React.createElement(
    'div',
    null,
    React.createElement(ReporterSortMessage, { scope: scope }),
    React.createElement(
      'div',
      { className: 'eupathdb-ReporterForm' },
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__right' },
        React.createElement(CategoriesCheckboxTree
        // title and layout of the tree
        , { title: 'Choose Columns',
          searchBoxPlaceholder: 'Search Columns...',
          tree: util.getAttributeTree(ontology, recordClass.name, question)

          // state of the tree
          , selectedLeaves: formState.attributes,
          expandedBranches: formUiState.expandedAttributeNodes,
          searchTerm: formUiState.attributeSearchText

          // change handlers for each state element controlled by the tree
          , onChange: util.getAttributesChangeHandler('attributes', updateFormState, formState, recordClass),
          onUiChange: getUiUpdateHandler('expandedAttributeNodes'),
          onSearchTermChange: getUiUpdateHandler('attributeSearchText')
        })
      ),
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__left' },
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Download Type'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(RadioList, { value: formState.attachmentType, items: util.tabularAttachmentTypes,
              onChange: getUpdateHandler('attachmentType') })
          )
        ),
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Additional Options'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(
              'label',
              null,
              React.createElement(Checkbox, { value: formState.includeHeader, onChange: getUpdateHandler('includeHeader') }),
              React.createElement(
                'span',
                { style: { marginLeft: '0.5em' } },
                'Include header row (column names)'
              )
            )
          )
        ),
        React.createElement(
          'div',
          { style: { margin: '2em 0' } },
          React.createElement(
            'button',
            { className: 'btn', type: 'submit', onClick: onSubmit },
            'Get ',
            recordClass.displayNamePlural
          )
        )
      )
    ),
    React.createElement('hr', null),
    React.createElement(
      'div',
      { style: { margin: '0.5em 2em' } },
      React.createElement(__WEBPACK_IMPORTED_MODULE_1__ExcelNote__["default"], null)
    ),
    React.createElement('hr', null)
  );
};

TabularReporterForm.getInitialState = function (downloadFormStoreState) {
  var scope = downloadFormStoreState.scope,
      question = downloadFormStoreState.question,
      recordClass = downloadFormStoreState.recordClass,
      _downloadFormStoreSta = downloadFormStoreState.globalData,
      ontology = _downloadFormStoreSta.ontology,
      preferences = _downloadFormStoreSta.preferences;
  // select all attribs and tables for record page, else column user prefs and no tables

  var allReportScopedAttrs = util.getAllLeafIds(util.getAttributeTree(ontology, recordClass.name, question));
  var attribs = util.addPk(scope === 'results' ? util.getAttributeSelections(preferences, question, allReportScopedAttrs) : allReportScopedAttrs, recordClass);
  return {
    formState: {
      attributes: attribs,
      includeHeader: true,
      attachmentType: "plain"
    },
    formUiState: {
      expandedAttributeNodes: null,
      attributeSearchText: ""
    }
  };
};

/* harmony default export */ __webpack_exports__["default"] = (TabularReporterForm);

/***/ }),
/* 23 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__ = __webpack_require__(9);


var TextReporterForm = function TextReporterForm(props) {
  return React.createElement(__WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"], props);
};

TextReporterForm.getInitialState = __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"].getInitialState;

/* harmony default export */ __webpack_exports__["default"] = (TextReporterForm);

/***/ }),
/* 24 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__ = __webpack_require__(9);


var XmlReporterForm = function XmlReporterForm(props) {
  return React.createElement(__WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"], props);
};

XmlReporterForm.getInitialState = __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"].getInitialState;

/* harmony default export */ __webpack_exports__["default"] = (XmlReporterForm);

/***/ }),
/* 25 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__ = __webpack_require__(9);


var JsonReporterForm = function JsonReporterForm(props) {
  return React.createElement(__WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"], props);
};

JsonReporterForm.getInitialState = __WEBPACK_IMPORTED_MODULE_0__SharedReporterForm__["default"].getInitialState;

/* harmony default export */ __webpack_exports__["default"] = (JsonReporterForm);

/***/ }),
/* 26 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);


var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox;


var attachmentTypes = [{ value: "text", display: "GFF File" }, { value: "plain", display: "Show in Browser" }];

var GffInputs = function GffInputs(props) {
  var recordClass = props.recordClass,
      formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  if (recordClass.name != "TranscriptRecordClasses.TranscriptRecordClass") {
    return React.createElement("noscript", null);
  }
  return React.createElement(
    "div",
    { style: { marginLeft: '2em' } },
    React.createElement(Checkbox, { value: formState.hasTranscript, onChange: getUpdateHandler('hasTranscript') }),
    "Include Predicted RNA/mRNA Sequence (introns spliced out)",
    React.createElement("br", null),
    React.createElement(Checkbox, { value: formState.hasProtein, onChange: getUpdateHandler('hasProtein') }),
    "Include Predicted Protein Sequence",
    React.createElement("br", null)
  );
};

var Gff3ReporterForm = function Gff3ReporterForm(props) {
  var formState = props.formState,
      recordClass = props.recordClass,
      updateFormState = props.updateFormState,
      onSubmit = props.onSubmit;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  return React.createElement(
    "div",
    null,
    React.createElement(
      "h3",
      null,
      "Generate a report of your query result in GFF3 format"
    ),
    React.createElement(GffInputs, { formState: formState, recordClass: recordClass, getUpdateHandler: getUpdateHandler }),
    React.createElement(
      "div",
      null,
      React.createElement(
        "h3",
        null,
        "Download Type:"
      ),
      React.createElement(
        "div",
        { style: { marginLeft: "2em" } },
        React.createElement(RadioList, { name: "attachmentType", value: formState.attachmentType,
          onChange: getUpdateHandler('attachmentType'), items: attachmentTypes })
      )
    ),
    React.createElement(
      "div",
      { className: "eupathdb-ReporterFormSubmit" },
      React.createElement(
        "button",
        { className: "btn", type: "submit", onClick: onSubmit },
        "Get GFF3 file"
      )
    )
  );
};

var initialStateMap = {
  "SequenceRecordClasses.SequenceRecordClass": {
    attachmentType: 'plain'
  },
  "TranscriptRecordClasses.TranscriptRecordClass": {
    hasTranscript: false,
    hasProtein: false,
    attachmentType: 'plain'
  }
};

Gff3ReporterForm.getInitialState = function (downloadFormStoreState) {
  var recordClassName = downloadFormStoreState.recordClass.name;
  return {
    formState: recordClassName in initialStateMap ? initialStateMap[recordClassName] : {},
    formUiState: {}
  };
};

/* harmony default export */ __webpack_exports__["default"] = (Gff3ReporterForm);

/***/ }),
/* 27 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__SrtHelp__ = __webpack_require__(10);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    RadioList = _Wdk$Components.RadioList,
    SingleSelect = _Wdk$Components.SingleSelect,
    TextBox = _Wdk$Components.TextBox;


var sequenceTypes = [{ value: 'genomic', display: 'Genomic' }, { value: 'protein', display: 'Protein' }, { value: 'CDS', display: 'CDS' }, { value: 'processed_transcript', display: 'Transcript' }];

var defaultSourceIdFilterValue = 'genesOnly';

var sourceIdFilterTypes = [{ value: 'genesOnly', display: 'One sequence per gene in your result' }, { value: 'transcriptsOnly', display: 'One sequence per transcript in your result' }];

var genomicAnchorValues = [{ value: 'Start', display: 'Transcription Start***' }, { value: 'CodeStart', display: 'Translation Start (ATG)' }, { value: 'CodeEnd', display: 'Translation Stop Codon' }, { value: 'End', display: 'Transcription Stop***' }];

var proteinAnchorValues = [{ value: 'Start', display: 'Downstream from Start' }, { value: 'End', display: 'Upstream from End' }];

var signs = [{ value: 'plus', display: '+' }, { value: 'minus', display: '-' }];

var SequenceRegionRange = function SequenceRegionRange(props) {
  var label = props.label,
      anchor = props.anchor,
      sign = props.sign,
      offset = props.offset,
      formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  return React.createElement(
    'div',
    null,
    React.createElement(
      'span',
      null,
      label
    ),
    React.createElement(SingleSelect, { name: anchor, value: formState[anchor],
      onChange: getUpdateHandler(anchor), items: genomicAnchorValues }),
    React.createElement(SingleSelect, { name: sign, value: formState[sign],
      onChange: getUpdateHandler(sign), items: signs }),
    React.createElement(TextBox, { name: offset, value: formState[offset],
      onChange: getUpdateHandler(offset), size: '6' }),
    'nucleotides'
  );
};

var ProteinRegionRange = function ProteinRegionRange(props) {
  var label = props.label,
      anchor = props.anchor,
      offset = props.offset,
      formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  return React.createElement(
    'div',
    null,
    React.createElement(
      'span',
      null,
      label
    ),
    React.createElement(SingleSelect, { name: anchor, value: formState[anchor],
      onChange: getUpdateHandler(anchor), items: proteinAnchorValues }),
    React.createElement(TextBox, { name: offset, value: formState[offset],
      onChange: getUpdateHandler(offset), size: '6' }),
    'aminoacids'
  );
};

var SequenceRegionInputs = function SequenceRegionInputs(props) {
  var formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  switch (formState.type) {
    case 'genomic':
      return React.createElement(
        'div',
        null,
        React.createElement('hr', null),
        React.createElement(
          'h3',
          null,
          'Choose the region of the sequence(s):'
        ),
        React.createElement(SequenceRegionRange, { label: 'Begin at', anchor: 'upstreamAnchor', sign: 'upstreamSign',
          offset: 'upstreamOffset', formState: formState, getUpdateHandler: getUpdateHandler }),
        React.createElement(SequenceRegionRange, { label: 'End at', anchor: 'downstreamAnchor', sign: 'downstreamSign',
          offset: 'downstreamOffset', formState: formState, getUpdateHandler: getUpdateHandler })
      );
    case 'protein':
      return React.createElement(
        'div',
        null,
        React.createElement('hr', null),
        React.createElement(
          'h3',
          null,
          'Choose the region of the protein sequence(s):'
        ),
        React.createElement(ProteinRegionRange, { label: 'Begin at', anchor: 'startAnchor3', offset: 'startOffset3',
          formState: formState, getUpdateHandler: getUpdateHandler }),
        React.createElement(ProteinRegionRange, { label: 'End at', anchor: 'endAnchor3', offset: 'endOffset3',
          formState: formState, getUpdateHandler: getUpdateHandler })
      );
    default:
      return React.createElement('noscript', null);
  }
};

var FastaGeneReporterForm = function FastaGeneReporterForm(props) {
  var formState = props.formState,
      updateFormState = props.updateFormState,
      onSubmit = props.onSubmit;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  var typeUpdateHandler = function typeUpdateHandler(newTypeValue) {
    // any time type changes, revert sourceIdFilter back to default value
    updateFormState(Object.assign({}, formState, { type: newTypeValue, sourceIdFilter: defaultSourceIdFilterValue }));
  };
  return React.createElement(
    'div',
    null,
    React.createElement(
      'h3',
      null,
      'Choose the type of sequence:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { name: 'type', value: formState.type,
        onChange: typeUpdateHandler, items: sequenceTypes })
    ),
    /* show filter if type not genomic */
    formState.type === 'genomic' ? '' : React.createElement(
      'div',
      null,
      React.createElement(
        'h3',
        null,
        'Choose Genes or Transcripts:'
      ),
      React.createElement(
        'div',
        { style: { marginLeft: "2em" } },
        React.createElement(RadioList, { name: 'sourceIdFilter', value: formState.sourceIdFilter,
          onChange: getUpdateHandler('sourceIdFilter'), items: sourceIdFilterTypes })
      )
    ),
    React.createElement(SequenceRegionInputs, { formState: formState, getUpdateHandler: getUpdateHandler }),
    React.createElement('hr', null),
    React.createElement(
      'h3',
      null,
      'Download Type:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { name: 'attachmentType', value: formState.attachmentType,
        onChange: getUpdateHandler('attachmentType'), items: util.attachmentTypes })
    ),
    React.createElement(
      'div',
      { style: { margin: '0.8em' } },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Get Sequences'
      )
    ),
    React.createElement(
      'div',
      null,
      React.createElement('hr', null),
      React.createElement(
        'b',
        null,
        'Note:'
      ),
      React.createElement('br', null),
      'For "genomic" sequence: If UTRs have not been annotated for a gene, then choosing "transcription start" may have the same effect as choosing "translation start".',
      React.createElement('br', null),
      'For "protein" sequence: you can only retrieve sequence contained within the ID(s) listed. i.e. from downstream of amino acid sequence start (ie. Methionine = 0) to upstream of the amino acid end (last amino acid in the protein = 0).',
      React.createElement('br', null),
      React.createElement('hr', null)
    ),
    React.createElement(__WEBPACK_IMPORTED_MODULE_1__SrtHelp__["default"], null)
  );
};

FastaGeneReporterForm.getInitialState = function () {
  return {
    formState: {
      attachmentType: 'plain',
      type: 'genomic',
      sourceIdFilter: defaultSourceIdFilterValue,

      // sequence region inputs for 'genomic'
      upstreamAnchor: 'Start',
      upstreamSign: 'plus',
      upstreamOffset: 0,
      downstreamAnchor: 'End',
      downstreamSign: 'plus',
      downstreamOffset: 0,

      // sequence region inputs for 'protein'
      startAnchor3: 'Start',
      startOffset3: 0,
      endAnchor3: 'End',
      endOffset3: 0
    },
    formUiState: {}
  };
};

/* harmony default export */ __webpack_exports__["default"] = (FastaGeneReporterForm);

/***/ }),
/* 28 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__SrtHelp__ = __webpack_require__(10);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox,
    TextBox = _Wdk$Components.TextBox;


var FastaGenomicSequenceReporterForm = function FastaGenomicSequenceReporterForm(props) {
  var formState = props.formState,
      updateFormState = props.updateFormState,
      onSubmit = props.onSubmit;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };

  return React.createElement(
    'div',
    null,
    React.createElement(
      'h3',
      null,
      'Choose the region of the sequence(s):'
    ),
    React.createElement(
      'div',
      { style: { margin: "2em" } },
      React.createElement(Checkbox, { value: formState.revComp, onChange: getUpdateHandler('revComp') }),
      ' Reverse & Complement'
    ),
    React.createElement(
      'div',
      { style: { margin: "2em" } },
      React.createElement(
        'b',
        null,
        'Nucleotide positions:'
      ),
      React.createElement(TextBox, { value: formState.start, onChange: getUpdateHandler('start'), size: '6' }),
      ' to',
      React.createElement(TextBox, { value: formState.end, onChange: getUpdateHandler('end'), size: '6' }),
      ' (0 = end)'
    ),
    React.createElement('hr', null),
    React.createElement(
      'h3',
      null,
      'Download Type:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { value: formState.attachmentType, items: util.attachmentTypes,
        onChange: getUpdateHandler('attachmentType') })
    ),
    React.createElement(
      'div',
      { style: { margin: '0.8em' } },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Get Sequences'
      )
    ),
    React.createElement(
      'div',
      null,
      React.createElement('hr', null),
      React.createElement(
        'h3',
        null,
        'Options:'
      ),
      React.createElement(
        'ul',
        null,
        React.createElement(
          'li',
          null,
          React.createElement(
            'i',
            null,
            React.createElement(
              'b',
              null,
              'complete sequence'
            )
          ),
          ' to retrieve the complete sequence for the requested genomic regions, use "Nucleotide positions 1 to 10000"'
        ),
        React.createElement(
          'li',
          null,
          React.createElement(
            'i',
            null,
            React.createElement(
              'b',
              null,
              'specific sequence region'
            )
          ),
          ' to retrieve a specific region for the requested genomic regions, use "Nucleotide positions "',
          React.createElement(
            'i',
            null,
            'x'
          ),
          ' to ',
          React.createElement(
            'i',
            null,
            'y'
          ),
          ', where ',
          React.createElement(
            'i',
            null,
            'y'
          ),
          ' is greater than ',
          React.createElement(
            'i',
            null,
            'x'
          )
        )
      ),
      React.createElement('hr', null)
    ),
    React.createElement(__WEBPACK_IMPORTED_MODULE_1__SrtHelp__["default"], null)
  );
};

FastaGenomicSequenceReporterForm.getInitialState = function () {
  return {
    formState: {
      attachmentType: 'plain',
      revComp: true,
      start: 1,
      end: 0
    },
    formUiState: {}
  };
};

/* harmony default export */ __webpack_exports__["default"] = (FastaGenomicSequenceReporterForm);

/***/ }),
/* 29 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__SrtHelp__ = __webpack_require__(10);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    TextBox = _Wdk$Components.TextBox,
    RadioList = _Wdk$Components.RadioList,
    SingleSelect = _Wdk$Components.SingleSelect;


var sequenceTypes = [{ value: 'genomic', display: 'Genomic' }, { value: 'protein', display: 'Protein' }];

var genomicAnchorValues = [{ value: 'Start', display: 'Start' }, { value: 'End', display: 'Stop' }];

var signs = [{ value: 'plus', display: '+' }, { value: 'minus', display: '-' }];

var SequenceRegionRange = function SequenceRegionRange(props) {
  var label = props.label,
      anchor = props.anchor,
      sign = props.sign,
      offset = props.offset,
      formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  return React.createElement(
    'div',
    null,
    React.createElement(
      'span',
      null,
      label
    ),
    React.createElement(SingleSelect, { name: anchor, value: formState[anchor],
      onChange: getUpdateHandler(anchor), items: genomicAnchorValues }),
    React.createElement(SingleSelect, { name: sign, value: formState[sign],
      onChange: getUpdateHandler(sign), items: signs }),
    React.createElement(TextBox, { name: offset, value: formState[offset],
      onChange: getUpdateHandler(offset), size: '6' }),
    'nucleotides'
  );
};

var SequenceRegionInputs = function SequenceRegionInputs(props) {
  var formState = props.formState,
      getUpdateHandler = props.getUpdateHandler;

  return formState.type != 'genomic' ? React.createElement('noscript', null) : React.createElement(
    'div',
    null,
    React.createElement(
      'h3',
      null,
      'Choose the region of the sequence(s):'
    ),
    React.createElement(SequenceRegionRange, { label: 'Begin at', anchor: 'upstreamAnchor', sign: 'upstreamSign',
      offset: 'upstreamOffset', formState: formState, getUpdateHandler: getUpdateHandler }),
    React.createElement(SequenceRegionRange, { label: 'End at', anchor: 'downstreamAnchor', sign: 'downstreamSign',
      offset: 'downstreamOffset', formState: formState, getUpdateHandler: getUpdateHandler })
  );
};

var FastaOrfReporterForm = function FastaOrfReporterForm(props) {
  var formState = props.formState,
      updateFormState = props.updateFormState,
      onSubmit = props.onSubmit;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };

  return React.createElement(
    'div',
    null,
    React.createElement(
      'h3',
      null,
      'Choose the type of sequence:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { name: 'type', value: formState.type,
        onChange: getUpdateHandler('type'), items: sequenceTypes })
    ),
    React.createElement(SequenceRegionInputs, { formState: formState, getUpdateHandler: getUpdateHandler }),
    React.createElement('hr', null),
    React.createElement(
      'h3',
      null,
      'Download Type:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { name: 'attachmentType', value: formState.attachmentType,
        onChange: getUpdateHandler('attachmentType'), items: util.attachmentTypes })
    ),
    React.createElement(
      'div',
      { style: { margin: '0.8em' } },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Get Sequences'
      )
    ),
    React.createElement(__WEBPACK_IMPORTED_MODULE_1__SrtHelp__["default"], null)
  );
};

FastaOrfReporterForm.getInitialState = function () {
  return {
    formState: {
      attachmentType: 'plain',
      type: 'genomic',

      // sequence region inputs for 'genomic'
      upstreamAnchor: 'Start',
      upstreamSign: 'plus',
      upstreamOffset: 0,
      downstreamAnchor: 'End',
      downstreamSign: 'plus',
      downstreamOffset: 0
    },
    formUiState: {}
  };
};

/* harmony default export */ __webpack_exports__["default"] = (FastaOrfReporterForm);

/***/ }),
/* 30 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);


var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox;


var FastaOrthoSequenceReporterForm = function FastaOrthoSequenceReporterForm(props) {
  var formState = props.formState,
      updateFormState = props.updateFormState,
      onSubmit = props.onSubmit;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };

  return React.createElement(
    'div',
    null,
    React.createElement(
      'h3',
      null,
      'Output options:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: '2em' } },
      React.createElement(
        'div',
        { style: { display: 'block' } },
        React.createElement(Checkbox, { value: formState.includeOrganism, onChange: getUpdateHandler('includeOrganism') }),
        ' Include organism'
      ),
      React.createElement(
        'div',
        { style: { display: 'block' } },
        React.createElement(Checkbox, { value: formState.includeDescription, onChange: getUpdateHandler('includeDescription') }),
        ' Include description'
      )
    ),
    React.createElement('hr', null),
    React.createElement(
      'h3',
      null,
      'Download Type:'
    ),
    React.createElement(
      'div',
      { style: { marginLeft: "2em" } },
      React.createElement(RadioList, { value: formState.attachmentType, items: util.attachmentTypes,
        onChange: getUpdateHandler('attachmentType') })
    ),
    React.createElement(
      'div',
      { style: { margin: '0.8em' } },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Download'
      )
    )
  );
};

FastaOrthoSequenceReporterForm.getInitialState = function () {
  return {
    formState: {
      attachmentType: 'plain',
      includeOrganism: false,
      includeDescription: false
    },
    formUiState: {}
  };
};

/* harmony default export */ __webpack_exports__["default"] = (FastaOrthoSequenceReporterForm);

/***/ }),
/* 31 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__TableReporterForm__ = __webpack_require__(12);



var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"]);

// Transcript Table Reporter is the same as a regular Table Reporter, but need to
//   override the recordClass (Transcript) with Gene to get Gene tables for a Transcript result
var recordClassOverride = { recordClass: { name: "GeneRecordClasses.GeneRecordClass" } };

var TranscriptTableReporterForm = function TranscriptTableReporterForm(props) {
  var newProps = Object.assign({}, props, recordClassOverride);
  return React.createElement(__WEBPACK_IMPORTED_MODULE_1__TableReporterForm__["default"], newProps);
};

TranscriptTableReporterForm.getInitialState = function (downloadFormStoreState) {
  var newDownloadFormStoreState = Object.assign({}, downloadFormStoreState, recordClassOverride);
  return __WEBPACK_IMPORTED_MODULE_1__TableReporterForm__["default"].getInitialState(newDownloadFormStoreState);
};

/* harmony default export */ __webpack_exports__["default"] = (TranscriptTableReporterForm);

/***/ }),
/* 32 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__ExcelNote__ = __webpack_require__(8);
function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }




var util = Object.assign({}, __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ComponentUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["ReporterUtils"], __WEBPACK_IMPORTED_MODULE_0_wdk_client__["CategoryUtils"]);
var _Wdk$Components = __WEBPACK_IMPORTED_MODULE_0_wdk_client__["Components"],
    CategoriesCheckboxTree = _Wdk$Components.CategoriesCheckboxTree,
    RadioList = _Wdk$Components.RadioList,
    Checkbox = _Wdk$Components.Checkbox,
    ReporterSortMessage = _Wdk$Components.ReporterSortMessage;


var TranscriptAttributesReporterForm = function TranscriptAttributesReporterForm(props) {
  var scope = props.scope,
      question = props.question,
      recordClass = props.recordClass,
      formState = props.formState,
      formUiState = props.formUiState,
      updateFormState = props.updateFormState,
      updateFormUiState = props.updateFormUiState,
      onSubmit = props.onSubmit,
      ontology = props.globalData.ontology;

  var getUpdateHandler = function getUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormState, formState);
  };
  var getUiUpdateHandler = function getUiUpdateHandler(fieldName) {
    return util.getChangeHandler(fieldName, updateFormUiState, formUiState);
  };

  var transcriptAttribChangeHandler = function transcriptAttribChangeHandler(newAttribsArray) {
    updateFormState(Object.assign({}, formState, _defineProperty({}, 'attributes', util.addPk(util.prependAttrib('source_id', newAttribsArray), recordClass))));
  };

  return React.createElement(
    'div',
    null,
    React.createElement(ReporterSortMessage, { scope: scope }),
    React.createElement(
      'div',
      { className: 'eupathdb-ReporterForm' },
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__columns' },
        React.createElement(CategoriesCheckboxTree
        // title and layout of the tree
        , { title: 'Choose Columns',
          searchBoxPlaceholder: 'Search Columns...',
          tree: util.getAttributeTree(ontology, recordClass.name, question)

          // state of the tree
          , selectedLeaves: formState.attributes,
          expandedBranches: formUiState.expandedAttributeNodes,
          searchTerm: formUiState.attributeSearchText

          // change handlers for each state element controlled by the tree
          , onChange: transcriptAttribChangeHandler,
          onUiChange: getUiUpdateHandler('expandedAttributeNodes'),
          onSearchTermChange: getUiUpdateHandler('attributeSearchText')
        })
      ),
      React.createElement(
        'div',
        { className: 'eupathdb-ReporterFormGroup eupathdb-ReporterFormGroup__otherOptions' },
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Choose Rows'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(
              'label',
              null,
              React.createElement(Checkbox, { value: formState.applyFilter, onChange: getUpdateHandler('applyFilter') }),
              React.createElement(
                'span',
                { style: { marginLeft: '0.5em' } },
                'Include only one transcript per gene (the longest)'
              )
            )
          )
        ),
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Download Type'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(RadioList, { value: formState.attachmentType, items: util.tabularAttachmentTypes,
              onChange: getUpdateHandler('attachmentType') })
          )
        ),
        React.createElement(
          'div',
          null,
          React.createElement(
            'h3',
            null,
            'Additional Options'
          ),
          React.createElement(
            'div',
            null,
            React.createElement(
              'label',
              null,
              React.createElement(Checkbox, { value: formState.includeHeader, onChange: getUpdateHandler('includeHeader') }),
              React.createElement(
                'span',
                { style: { marginLeft: '0.5em' } },
                'Include header row (column names)'
              )
            )
          )
        )
      )
    ),
    React.createElement(
      'div',
      { className: 'eupathdb-ReporterFormSubmit' },
      React.createElement(
        'button',
        { className: 'btn', type: 'submit', onClick: onSubmit },
        'Get Genes'
      )
    ),
    React.createElement('hr', null),
    React.createElement(
      'div',
      { style: { margin: '0.5em 2em' } },
      React.createElement(__WEBPACK_IMPORTED_MODULE_1__ExcelNote__["default"], null)
    ),
    React.createElement('hr', null)
  );
};

function getUserPrefFilterValue(prefs) {
  var prefValue = prefs['representativeTranscriptOnly'];
  return prefValue !== undefined && prefValue === "true";
}

TranscriptAttributesReporterForm.getInitialState = function (downloadFormStoreState) {
  var scope = downloadFormStoreState.scope,
      question = downloadFormStoreState.question,
      recordClass = downloadFormStoreState.recordClass,
      _downloadFormStoreSta = downloadFormStoreState.globalData,
      ontology = _downloadFormStoreSta.ontology,
      preferences = _downloadFormStoreSta.preferences;
  // select all attribs and tables for record page, else column user prefs and no tables

  var allReportScopedAttrs = util.getAllLeafIds(util.getAttributeTree(ontology, recordClass.name, question));
  var attribs = util.addPk(util.prependAttrib('source_id', scope === 'results' ? util.getAttributeSelections(preferences, question, allReportScopedAttrs) : allReportScopedAttrs), recordClass);
  return {
    formState: {
      attributes: attribs,
      includeHeader: true,
      attachmentType: "plain",
      applyFilter: getUserPrefFilterValue(preferences)
    },
    formUiState: {
      expandedAttributeNodes: null,
      attributeSearchText: ""
    }
  };
};

/* harmony default export */ __webpack_exports__["default"] = (TranscriptAttributesReporterForm);

/***/ }),
/* 33 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = Footer;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__NewWindowLink__ = __webpack_require__(34);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_formatters__ = __webpack_require__(58);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__config__ = __webpack_require__(21);




/** Application footer */
function Footer() {
  return React.createElement(
    'div',
    { className: 'wide-footer ui-helper-clearfix', id: 'fixed-footer' },
    React.createElement(
      'div',
      { className: 'left' },
      React.createElement(
        'div',
        { className: 'build-info' },
        React.createElement(
          'span',
          null,
          React.createElement(
            'a',
            { href: 'https://beta.' + __WEBPACK_IMPORTED_MODULE_2__config__["projectId"].toLowerCase() + '.org' },
            __WEBPACK_IMPORTED_MODULE_2__config__["displayName"]
          ),
          React.createElement(
            'span',
            null,
            ' ',
            __WEBPACK_IMPORTED_MODULE_2__config__["buildNumber"],
            ' \xA0\xA0 ',
            Object(__WEBPACK_IMPORTED_MODULE_1__util_formatters__["a" /* formatReleaseDate */])(__WEBPACK_IMPORTED_MODULE_2__config__["releaseDate"])
          )
        ),
        React.createElement('br', null)
      ),
      React.createElement(
        'div',
        { className: 'copyright' },
        '\xA9',
        new Date().getFullYear(),
        ' The VEuPathDB Project Team'
      ),
      React.createElement(
        'div',
        { className: 'twitter-footer' },
        'Follow us on',
        React.createElement('a', { className: 'eupathdb-SocialMedia eupathdb-SocialMedia__twitter', href: 'https://twitter.com/MicrobiomeDB', target: '_blank' })
      )
    ),
    React.createElement(
      'div',
      { className: 'right' },
      React.createElement(
        'ul',
        { className: 'attributions' },
        React.createElement(
          'li',
          null,
          React.createElement(
            'a',
            { href: 'http://code.google.com/p/strategies-wdk/' },
            React.createElement('img', { width: '120', src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/wdk/images/stratWDKlogo.png' })
          )
        )
      ),
      React.createElement(
        'div',
        { className: 'contact' },
        'Please ',
        React.createElement(
          __WEBPACK_IMPORTED_MODULE_0__NewWindowLink__["default"],
          { href: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/contact.do' },
          'Contact Us'
        ),
        ' with any questions or comments'
      )
    ),
    React.createElement(
      'div',
      { className: 'bottom' },
      React.createElement(
        'ul',
        { className: 'site-icons' },
        React.createElement(
          'li',
          { title: 'beta.VEuPathDB.org' },
          React.createElement(
            'a',
            { href: 'https://beta.veupathdb.org' },
            React.createElement('img', { alt: 'Link to VEuPathDB homepage', src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/VEuPathDB.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.AmoebaDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.amoebadb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/AmoebaDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.CryptoDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.cryptodb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/CryptoDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.FungiDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.fungidb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/FungiDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.GiardiaDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.giardiadb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/GiardiaDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.MicrosporidiaDB.org', className: 'long-space' },
          React.createElement(
            'a',
            { href: 'https://beta.microsporidiadb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/MicrosporidiaDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.PiroplasmaDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.piroplasmadb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/PiroplasmaDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.PlasmoDB.org', className: 'long-space' },
          React.createElement(
            'a',
            { href: 'https://beta.plasmodb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/PlasmoDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.ToxoDB.org', className: 'long-space' },
          React.createElement(
            'a',
            { href: 'https://beta.toxodb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/ToxoDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.TrichDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.trichdb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/TrichDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.TriTrypDB.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.tritrypdb.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/TriTrypDB/footer-logo.png' })
          )
        ),
        React.createElement(
          'li',
          { title: 'beta.OrthoMCL.org', className: 'short-space' },
          React.createElement(
            'a',
            { href: 'https://beta.orthomcl.org' },
            React.createElement('img', { src: __WEBPACK_IMPORTED_MODULE_2__config__["webAppUrl"] + '/images/OrthoMCL/footer-logo.png' })
          )
        )
      )
    )
  );
}

/***/ }),
/* 34 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = NewWindowLink;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);

function NewWindowLink(props) {
  var href = props.href,
      className = props.className,
      _props$windowName = props.windowName,
      windowName = _props$windowName === undefined ? 'apidb_window' : _props$windowName,
      _props$onClick = props.onClick,
      _onClick = _props$onClick === undefined ? function () {} : _props$onClick,
      children = props.children;

  return React.createElement(
    'a',
    {
      href: href,
      className: className,
      onClick: function onClick(e) {
        _onClick(e);
        if (!e.isDefaultPrevented()) {
          e.preventDefault();
          openPopup(e.currentTarget.href, windowName);
        }
      }
    },
    children
  );
}

function openPopup(windowUrl, windowName) {
  var windowWidth = 1050;
  var windowHeight = 740;
  var windowLeft = screen.width / 2 - windowWidth / 2;
  var windowTop = screen.height / 2 - windowHeight / 2;
  var defaultFeatures = {
    location: "no",
    menubar: "no",
    toolbar: "no",
    personalbar: "no",
    resizable: "yes",
    scrollbars: "yes",
    status: "yes",
    width: windowWidth,
    height: windowHeight,
    top: windowTop,
    left: windowLeft
  };

  var windowFeatures = Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["map"])(defaultFeatures, function (v, k) {
    return k + "=" + v;
  }).join(",");
  window.open(windowUrl, windowName.replace(/-/g, "_"), windowFeatures).focus();
}

/***/ }),
/* 35 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__util_formatters__ = __webpack_require__(58);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__util_menuItems__ = __webpack_require__(81);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__Announcements__ = __webpack_require__(36);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__QuickSearch__ = __webpack_require__(37);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__SmallMenu__ = __webpack_require__(38);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__Menu__ = __webpack_require__(39);











/** Site header */
function Header(props) {
  var quickSearches = props.quickSearches,
      user = props.user,
      showLoginWarning = props.showLoginWarning,
      _props$location = props.location,
      location = _props$location === undefined ? window.location : _props$location,
      siteConfig = props.siteConfig;
  var _siteConfig$isPartOfE = siteConfig.isPartOfEuPathDB,
      isPartOfEuPathDB = _siteConfig$isPartOfE === undefined ? true : _siteConfig$isPartOfE,
      _siteConfig$mainMenuI = siteConfig.mainMenuItems,
      mainMenuItems = _siteConfig$mainMenuI === undefined ? __WEBPACK_IMPORTED_MODULE_0_lodash__["noop"] : _siteConfig$mainMenuI,
      _siteConfig$smallMenu = siteConfig.smallMenuItems,
      smallMenuItems = _siteConfig$smallMenu === undefined ? __WEBPACK_IMPORTED_MODULE_0_lodash__["noop"] : _siteConfig$smallMenu,
      quickSearchReferences = siteConfig.quickSearchReferences,
      announcements = siteConfig.announcements,
      buildNumber = siteConfig.buildNumber,
      projectId = siteConfig.projectId,
      releaseDate = siteConfig.releaseDate,
      webAppUrl = siteConfig.webAppUrl;


  var menuItems = Object(__WEBPACK_IMPORTED_MODULE_5__util_menuItems__["a" /* makeMenuItems */])(props);

  return React.createElement(
    'div',
    null,
    React.createElement(
      'div',
      { id: 'header' },
      React.createElement(
        'div',
        { id: 'header2' },
        React.createElement(
          'div',
          { id: 'header_rt' },
          React.createElement(
            'div',
            { id: 'private-Logo' },
            React.createElement(
              'a',
              { target: ':blank', href: 'http://www.vet.upenn.edu' },
              React.createElement('img', { width: '210px', src: webAppUrl + '/images/PrivateLogo.png' })
            )
          ),
          React.createElement(
            'div',
            { id: 'toplink' },
            isPartOfEuPathDB && React.createElement(
              'a',
              { href: 'http://veupathdb.org' },
              React.createElement('img', { alt: 'Link to VEuPathDB homepage', src: webAppUrl + '/images/project-branding.png' })
            )
          ),
          React.createElement(__WEBPACK_IMPORTED_MODULE_7__QuickSearch__["default"], {
            webAppUrl: webAppUrl,
            references: quickSearchReferences,
            questions: quickSearches
          }),
          React.createElement(__WEBPACK_IMPORTED_MODULE_8__SmallMenu__["default"], {
            webAppUrl: webAppUrl,
            items: smallMenuItems(props, menuItems)
          })
        ),
        React.createElement(
          'div',
          { className: 'eupathdb-Logo' },
          React.createElement(
            'a',
            { href: '/' },
            React.createElement('img', { className: 'eupathdb-LogoImage', alt: "Link to " + projectId + " homepage", src: webAppUrl + "/images/" + projectId + "/title_s.png" })
          ),
          React.createElement(
            'span',
            { className: 'eupathdb-LogoRelease' },
            'Release ',
            buildNumber,
            React.createElement('br', null),
            Object(__WEBPACK_IMPORTED_MODULE_4__util_formatters__["a" /* formatReleaseDate */])(releaseDate)
          )
        )
      ),
      React.createElement(
        __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["Sticky"],
        null,
        function (_ref) {
          var isFixed = _ref.isFixed;
          return React.createElement(
            'div',
            { className: 'eupathdb-MenuContainer' + (isFixed ? ' eupathdb-MenuContainer__fixed' : '') },
            React.createElement(__WEBPACK_IMPORTED_MODULE_9__Menu__["default"], {
              webAppUrl: webAppUrl,
              projectId: projectId,
              showLoginWarning: showLoginWarning,
              isGuest: user ? user.isGuest : true,
              items: mainMenuItems(props, menuItems) })
          );
        }
      )
    ),
    React.createElement(__WEBPACK_IMPORTED_MODULE_6__Announcements__["default"], { projectId: projectId, webAppUrl: webAppUrl, location: location, announcements: announcements })
  );
}

Header.propTypes = {
  // Global data items
  user: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  ontology: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  recordClasses: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.array,
  basketCounts: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  quickSearches: __WEBPACK_IMPORTED_MODULE_7__QuickSearch__["default"].propTypes.questions,
  preferences: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  location: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object,
  showLoginForm: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  showLoginWarning: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  showLogoutWarning: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  siteConfig: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired
};

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__["wrappable"])(Header));

/***/ }),
/* 36 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = Announcements;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__);




var AnnouncementPropTypes = {
  projectId: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.string.isRequired,
  webAppUrl: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.string.isRequired,
  location: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.object.isRequired,
  announcements: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.shape({
    information: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.arrayOf(__WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.string),
    degraded: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.arrayOf(__WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.string),
    down: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.arrayOf(__WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.string)
  })
};

var stopIcon = React.createElement(
  'span',
  { className: 'fa-stack', style: { fontSize: '1.6em' } },
  React.createElement('i', { className: 'fa fa-circle fa-stack-2x', style: { color: 'darkred' } }),
  React.createElement('i', { className: 'fa fa-times fa-stack-1x', style: { color: 'white' } })
);

var warningIcon = React.createElement(
  'span',
  { className: 'fa-stack', style: { fontSize: '1.6em' } },
  React.createElement('i', { className: 'fa fa-exclamation-triangle fa-stack-2x', style: { color: '#ffeb3b' } }),
  React.createElement('i', { className: 'fa fa-exclamation fa-stack-1x', style: { color: 'black', fontSize: '1.3em', top: 2 } })
);

var infoIcon = React.createElement(
  'span',
  { className: 'fa-stack', style: { fontSize: '1.6em' } },
  React.createElement('i', { className: 'fa fa-circle fa-stack-2x', style: { color: '#004aff' } }),
  React.createElement('i', { className: 'fa fa-info fa-stack-1x', style: { color: 'white' } })
);

// Array of announcements to show. Each element of the array is a function that takes props
// and returns a React Element. Use props as an opportunity to determine if the message should
// be displayed for the given context.
var siteAnnouncements = [
// alpha
function (props) {
  if (param('alpha', location) === 'true' || /^(alpha|a1|a2)/.test(location.hostname)) {
    return React.createElement(
      'div',
      { key: 'alpha' },
      'This pre-release version of ',
      props.projectId,
      ' is available for early community review. Your searches and strategies saved in this alpha release will not be available in the official release. Please explore the site and ',
      React.createElement(
        'a',
        { className: 'new-window', 'data-name': 'contact_us',
          href: props.webAppUrl + '/contact.do' },
        'contact us'
      ),
      ' with your feedback. This site is under active development so there may be incomplete or inaccurate data and occasional site outages can be expected.'
    );
  }
},

// beta
function (props) {
  if (param('beta', location) === 'true' || /^(beta|b1|b2)/.test(location.hostname)) {
    return React.createElement(
      'div',
      { key: 'beta' },
      'This pre-release version of ',
      props.projectId,
      ' is available for early community review. Please explore the site and ',
      React.createElement(
        'a',
        { className: 'new-window', 'data-name': 'contact_us',
          href: props.webAppUrl + '/contact.do' },
        'contact us'
      ),
      ' with your feedback. Note that any saved strategies in the beta sites will be lost once the sites are fully released. ',
      React.createElement(
        'a',
        { rel: 'noreferrer', href: 'https://' + props.projectId.toLowerCase() + '.' + (props.projectId === 'SchistoDB' ? 'net' : 'org') + '?useBetaSite=0' },
        'Click here to return to the legacy site.'
      )
    );
  }
},

// Blast
function (props) {
  if (props.projectId != 'OrthoMCL' && /showQuestion\.do.+blast/i.test(location.href)) {
    return React.createElement(
      'div',
      { key: 'blast' },
      'As of 3 Feb 2014, this search uses NCBI-BLAST to determine sequence similarity. Prior versions of the search used WU-BLAST.',
      React.createElement(
        'a',
        { target: '_blank', href: 'http://www.ncbi.nlm.nih.gov/blast/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs' },
        'NCBI-BLAST help.'
      )
    );
  }
  return null;
},

// OrthoMCL enzyme/compound
function (props) {
  if (props.projectId == 'OrthoMCL' && /(enzyme|compound)/i.test(location.href)) {
    return React.createElement(
      'div',
      { key: 'ortho-enzyme' },
      'Note: the Enzyme Commission (EC) numbers associated with proteins were obtained only from UniProt. In future releases we expect to include EC numbers from multiple sources including the annotation.'
    );
  }
  return null;
}

// Alt-splice release
/*
  (props) => {
    return props.projectId == 'OrthoMCL' ? null : (
      <div key="alt-splice-release">
Release 29 is an alpha release that includes significant updates to the underlying data and infrastructure. In addition to refreshing all data to the latest versions, we redesigned gene pages, incorporated alternative transcripts into gene pages and searches, and updated search categories.
Please <a className="new-window" data-name="contact_us" href="{props.webAppUrl}/contact.do"> Contact Us</a> to let us know what you think. Release 28 is still available and fully functional.
      </div>
    );
  }
*/
];

/**
 * Info box containing announcements.
 */
function Announcements(props) {
  var downAnnouncements = props.announcements.down.map(toElement);

  var degradedAnnouncements = props.announcements.degraded.map(toElement);

  var infoAnnouncements = props.announcements.information.map(toElement).concat(siteAnnouncements.map(invokeWith(props))); // map to React Elements

  return React.createElement(
    'div',
    null,
    React.createElement(AnnouncementGroup, { icon: stopIcon, announcements: downAnnouncements }),
    React.createElement(AnnouncementGroup, { icon: warningIcon, announcements: degradedAnnouncements }),
    React.createElement(AnnouncementGroup, { icon: infoIcon, announcements: infoAnnouncements })
  );
}

Announcements.propTypes = AnnouncementPropTypes;

/**
 * Box of announcements.
 */
function AnnouncementGroup(props) {
  var finalAnnouncements = props.announcements.filter(__WEBPACK_IMPORTED_MODULE_1_lodash__["identity"]).reduce(injectHr, null);

  return finalAnnouncements !== null && React.createElement(
    'div',
    { className: 'eupathdb-Announcement', style: {
        padding: '4px',
        border: '1px solid gray',
        margin: '4px',
        background: '#cdd9eb'
      } },
    React.createElement(
      'div',
      null,
      props.icon,
      React.createElement(
        'div',
        { style: {
            display: 'inline-block',
            width: 'calc(100% - 70px)',
            padding: '8px',
            verticalAlign: 'middle',
            fontSize: '1.1em'
          } },
        finalAnnouncements
      )
    )
  );
}

/**
 * Convert html string to a React Element
 *
 * @param {string} html
 * @return {React.Element}
 */
function toElement(html) {
  return Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(html, { key: html }, 'div');
}

/**
 * Join elements with <hr/>
 *
 * @param {React.Element[]|null} previous
 * @param {React.Element} next
 * @return {React.Element[]}
 */
function injectHr(previous, next) {
  return previous == null ? [next] : previous.concat(React.createElement('hr', null), next);
}

/**
 * Returns a function that takes another function and calls it with `args`.
 * @param {any[]} ...args
 * @return {(fn: Function) => any}
 */
function invokeWith() {
  for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
    args[_key] = arguments[_key];
  }

  return function (fn) {
    return fn.apply(undefined, args);
  };
}

/**
 * Find the value of the first param in the location object.
 *
 * @param {string} name The param name
 * @param {Location} location
 * @return {string?}
 */
function param(name, location) {
  return location.search.slice(1).split('&').map(function (entry) {
    return entry.split('=');
  }).filter(function (entry) {
    return entry[0] === name;
  }).map(function (entry) {
    return entry[1];
  }).map(decodeURIComponent).find(function () {
    return true;
  });
}

/***/ }),
/* 37 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_mesa__ = __webpack_require__(83);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_mesa___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_mesa__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_wdk_client_ComponentUtils__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }







var ParamPropType = __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.shape({
  defaultValue: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  help: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  name: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  alternate: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string
});

var ReferencePropType = __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.shape({
  name: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  paramName: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  displayName: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired
});

var QuestionPropType = __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.shape({
  name: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string,
  parameters: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.arrayOf(ParamPropType)
});

/**
 * Quick search boxes that appear in header
 */

var QuickSearchItem = function (_Component) {
  _inherits(QuickSearchItem, _Component);

  function QuickSearchItem(props) {
    _classCallCheck(this, QuickSearchItem);

    var _this = _possibleConstructorReturn(this, (QuickSearchItem.__proto__ || Object.getPrototypeOf(QuickSearchItem)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    _this.handleSubmit = _this.handleSubmit.bind(_this);
    _this.componentDidMount = _this.componentDidMount.bind(_this);
    _this.componentWillUnmount = _this.componentWillUnmount.bind(_this);
    _this.componentWillReceiveProps = _this.componentWillReceiveProps.bind(_this);
    _this.state = { value: '' };
    return _this;
  }

  _createClass(QuickSearchItem, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.setStateFromProps(this.props);
    }
  }, {
    key: 'componentWillUnmount',
    value: function componentWillUnmount() {}
  }, {
    key: 'componentWillReceiveProps',
    value: function componentWillReceiveProps(props) {
      this.setStateFromProps(props);
    }
  }, {
    key: 'getStorageKey',
    value: function getStorageKey(props) {
      return 'ebrc::quicksearch::' + props.reference.name;
    }
  }, {
    key: 'getSearchParam',
    value: function getSearchParam(props) {
      return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["find"])(Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["get"])(props, 'question.parameters'), function (_ref) {
        var name = _ref.name;
        return name === props.reference.paramName;
      });
    }
  }, {
    key: 'setStateFromProps',
    value: function setStateFromProps(props) {
      var value = window.localStorage.getItem(this.getStorageKey(props));
      this.setState({
        value: value != null ? value : Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["get"])(this.getSearchParam(props), 'defaultValue', '')
      });
    }
  }, {
    key: 'handleChange',
    value: function handleChange(event) {
      this.setState({ value: event.target.value });
    }

    // Save value on submit

  }, {
    key: 'handleSubmit',
    value: function handleSubmit() {
      window.localStorage.setItem(this.getStorageKey(this.props), this.state.value);
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      var _props = this.props,
          question = _props.question,
          reference = _props.reference,
          webAppUrl = _props.webAppUrl;
      var displayName = reference.displayName;

      var linkName = reference.alternate || reference.name;
      var searchParam = this.getSearchParam(this.props);

      // if searchParam is null, assume not loaded and render non-functioning
      // placeholder search box, otherwise render functioning search box
      return React.createElement(
        'div',
        { className: 'quick-search-item', style: { margin: '0 .4em' }, key: reference.name },
        React.createElement(
          'form',
          {
            name: 'questionForm',
            method: 'post',
            action: webAppUrl + '/processQuestionSetsFlat.do',
            onSubmit: this.handleSubmit
          },
          React.createElement(
            __WEBPACK_IMPORTED_MODULE_3_mesa__["AnchoredTooltip"],
            {
              style: { maxWidth: '275px', boxSizing: 'border-box' },
              renderHtml: true,
              content: reference.help },
            question == null ? React.createElement(
              'fieldset',
              null,
              React.createElement(
                'b',
                { key: 'name' },
                React.createElement(
                  'a',
                  { href: webAppUrl + '/showQuestion.do?questionFullName=' + linkName },
                  displayName,
                  ': '
                )
              ),
              React.createElement('input', {
                type: 'text',
                key: 'input',
                className: 'search-box',
                value: this.state.value,
                onChange: this.handleChange,
                ref: function ref(el) {
                  return _this2.inputElement = el;
                },
                name: '',
                disabled: true
              }),
              React.createElement('input', {
                name: 'go',
                value: 'go',
                type: 'image',
                key: 'submit',
                src: webAppUrl + '/images/mag_glass.png',
                alt: 'Click to search',
                width: '23',
                height: '23',
                className: 'img_align_middle',
                disabled: true
              })
            ) : React.createElement(
              'fieldset',
              null,
              React.createElement('input', { type: 'hidden', name: 'questionFullName', value: question.name }),
              React.createElement('input', { type: 'hidden', name: 'questionSubmit', value: 'Get Answer' }),
              question.parameters.map(function (parameter) {
                if (parameter === searchParam) return null;
                var defaultValue = parameter.defaultValue,
                    type = parameter.type,
                    name = parameter.name;

                var typeTag = isStringParam(type) ? 'value' : 'array';
                return React.createElement('input', { key: typeTag + '(' + name + ')', type: 'hidden', name: name, value: defaultValue });
              }),
              React.createElement(
                'b',
                null,
                React.createElement(
                  'a',
                  { href: webAppUrl + '/showQuestion.do?questionFullName=' + linkName },
                  displayName,
                  ': '
                )
              ),
              React.createElement('input', {
                type: 'text',
                className: 'search-box',
                value: this.state.value,
                onChange: this.handleChange,
                name: 'value(' + searchParam.name + ')',
                ref: function ref(el) {
                  return _this2.inputElement = el;
                }
              }),
              React.createElement('input', {
                name: 'go',
                value: 'go',
                type: 'image',
                src: webAppUrl + '/images/mag_glass.png',
                alt: 'Click to search',
                width: '23',
                height: '23',
                className: 'img_align_middle'
              })
            )
          )
        )
      );
    }
  }]);

  return QuickSearchItem;
}(__WEBPACK_IMPORTED_MODULE_1_react__["Component"]);

QuickSearchItem.propTypes = {
  webAppUrl: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  question: QuestionPropType,
  reference: ReferencePropType.isRequired
};

function QuickSearch(props) {
  var references = props.references,
      _props$questions = props.questions,
      questions = _props$questions === undefined ? {} : _props$questions,
      webAppUrl = props.webAppUrl;


  return React.createElement(
    'div',
    { id: 'quick-search', style: { display: 'flex', marginBottom: '12px', marginTop: '16px', height: '26px' } },
    questions instanceof Error ? React.createElement(
      'div',
      { style: { color: 'darkred', marginLeft: 'auto' } },
      'Error: search temporarily unavailable'
    ) : Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["map"])(references, function (reference) {
      return React.createElement(QuickSearchItem, {
        key: reference.name,
        question: questions[reference.name],
        reference: reference,
        webAppUrl: webAppUrl
      });
    })
  );
}

QuickSearch.propTypes = {
  webAppUrl: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.string.isRequired,
  references: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.arrayOf(ReferencePropType),
  questions: __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.oneOfType([__WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.objectOf(QuestionPropType), __WEBPACK_IMPORTED_MODULE_2_prop_types___default.a.instanceOf(Error)])
};

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_4_wdk_client_ComponentUtils__["wrappable"])(QuickSearch));

/**
 * @param {Parameter} parameter
 * @return {boolean}
 */
function isStringParam(parameter) {
  return ['StringParam', 'TimestampParam'].includes(parameter.type);
}

/***/ }),
/* 38 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__);
var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };





/**
 * Small menu that appears in header
 */
var SmallMenu = function SmallMenu(_ref) {
  var items = _ref.items,
      webAppUrl = _ref.webAppUrl;
  return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["isEmpty"])(items) ? null : React.createElement(
    'ul',
    { className: 'eupathdb-SmallMenu' },
    items.filter(__WEBPACK_IMPORTED_MODULE_0_lodash__["identity"]).map(function (item, index) {
      return React.createElement(Item, { key: item.id || '_' + index, item: item, webAppUrl: webAppUrl });
    })
  );
};

SmallMenu.propTypes = {
  webAppUrl: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string.isRequired,
  items: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.array
};

/* harmony default export */ __webpack_exports__["default"] = (SmallMenu);

var Item = function Item(props) {
  return React.createElement(
    'li',
    { className: 'eupathdb-SmallMenuItem ' + (props.item.liClassName || '') },
    props.item.url ? React.createElement(ItemUrl, props) : props.item.webAppUrl ? React.createElement(ItemWebAppUrl, props) : props.item.route ? React.createElement(ItemRoute, props) : Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(props.item.text),
    React.createElement(SmallMenu, _extends({}, props, { items: props.item.children }))
  );
};

var ItemUrl = function ItemUrl(_ref2) {
  var item = _ref2.item;
  return React.createElement(
    'a',
    {
      className: item.className,
      title: item.tooltip,
      href: item.url,
      target: item.target,
      onClick: item.onClick
    },
    Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(item.text)
  );
};

var ItemWebAppUrl = function ItemWebAppUrl(_ref3) {
  var item = _ref3.item,
      webAppUrl = _ref3.webAppUrl;
  return React.createElement(
    'a',
    {
      className: item.className,
      title: item.tooltip,
      href: '' + webAppUrl + item.webAppUrl,
      onClick: item.onClick,
      target: item.target
    },
    Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(item.text)
  );
};

var ItemRoute = function ItemRoute(_ref4) {
  var item = _ref4.item,
      webAppUrl = _ref4.webAppUrl;
  return React.createElement(
    'a',
    {
      className: item.className,
      title: item.tooltip,
      href: webAppUrl + '/app' + item.route,
      onClick: item.onClick,
      target: item.target
    },
    Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(item.text)
  );
};

/***/ }),
/* 39 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = Menu;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__);
var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };





/**
 * Site menu
 */
function Menu(props) {
  return React.createElement(
    'ul',
    { className: 'eupathdb-Menu' },
    props.items.filter(__WEBPACK_IMPORTED_MODULE_0_lodash__["identity"]).map(function (item, index) {
      return React.createElement(MenuItem, {
        key: item.id || index,
        item: item,
        webAppUrl: props.webAppUrl,
        isGuest: props.isGuest,
        showLoginWarning: props.showLoginWarning,
        projectId: props.projectId
      });
    })
  );
}

Menu.propTypes = {
  webAppUrl: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string.isRequired,
  showLoginWarning: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func,
  items: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.array.isRequired,
  isGuest: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  projectId: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string.isRequired
};

/**
 * Site menu item.
 */
function MenuItem(props) {
  var item = props.item,
      webAppUrl = props.webAppUrl,
      showLoginWarning = props.showLoginWarning,
      isGuest = props.isGuest,
      projectId = props.projectId;


  if (!include(item, projectId)) return null;

  var handleClick = function handleClick(e) {
    if (item.onClick) {
      item.onClick(e);
    }
    if (item.loginRequired && isGuest) {
      e.preventDefault();
      showLoginWarning('use this feature', e.currentTarget.href);
    }
  };
  var baseClassName = 'eupathdb-MenuItemText';
  var className = baseClassName + ' ' + baseClassName + '__' + item.id + (item.beta ? ' ' + baseClassName + '__beta' : '') + (item.new ? ' ' + baseClassName + '__new' : '') + (!Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["isEmpty"])(item.children) ? ' ' + baseClassName + '__parent' : '');

  return React.createElement(
    'li',
    { className: 'eupathdb-MenuItem eupathdb-MenuItem__' + item.id },
    item.url ? React.createElement(
      'a',
      { onClick: handleClick, className: className, title: item.tooltip, href: item.url, target: item.target },
      renderItemText(item.text)
    ) : item.webAppUrl ? React.createElement(
      'a',
      { onClick: handleClick, className: className, title: item.tooltip, href: webAppUrl + item.webAppUrl },
      renderItemText(item.text)
    ) : item.route ? React.createElement(
      'a',
      { onClick: handleClick, className: className, title: item.tooltip, href: webAppUrl + '/app' + item.route },
      renderItemText(item.text)
    ) : React.createElement(
      'div',
      { className: className, title: item.tooltip },
      renderItemText(item.text)
    ),
    !Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["isEmpty"])(item.children) && React.createElement(
      'ul',
      { className: 'eupathdb-Submenu' },
      item.children.filter(__WEBPACK_IMPORTED_MODULE_0_lodash__["identity"]).map(function (childItem, index) {
        return React.createElement(MenuItem, _extends({}, props, {
          key: childItem.id || index,
          item: childItem
        }));
      })
    )
  );
}

MenuItem.propTypes = {
  webAppUrl: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string.isRequired,
  showLoginWarning: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func,
  item: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  isGuest: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.bool,
  projectId: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.string.isRequired
};

/**
 * Determine is menu item should be include for projectId
 */
function include(item, projectId) {
  var include = item.include,
      exclude = item.exclude;

  return include == null && exclude == null || include != null && include.indexOf(projectId) !== -1 || exclude != null && exclude.indexOf(projectId) === -1;
}

/**
 * Returns a render compatible element
 */
function renderItemText(text) {
  return typeof text === 'string' ? Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(text) : text;
}

/***/ }),
/* 40 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }



// Store user consent in browser storage
// -------------------------------------

var USER_AGREED_KEY = '@ebrc/agreed-cookies';

var UserAgreedStore = {
  get: function get() {
    return JSON.parse(window.localStorage.getItem(USER_AGREED_KEY) || "false");
  },
  set: function set(value) {
    return window.localStorage.setItem(USER_AGREED_KEY, JSON.stringify(Boolean(value)));
  }
};

var privacyPolicyLink = '/documents/EuPathDB_Website_Privacy_Policy.shtml';

// Styles
// ------

var bannerStyle = {
  position: 'fixed',
  bottom: 0,
  left: 0,
  right: 0,
  display: 'flex',
  justifyContent: 'space-around',
  alignItems: 'center',
  padding: '2em',
  fontSize: '1.2em',
  background: 'black',
  color: 'white',
  boxShadow: 'rgb(114, 114, 114) 0px -1px 1px',
  zIndex: 1000
};

var linkStyle = {
  color: '#96b1e9',
  textDecoration: 'underline',
  whiteSpace: 'nowrap'
};

/**
 * Inform user of cookie usage. Display banner until user clicks agree button.
 */

var CookieBanner = function (_React$Component) {
  _inherits(CookieBanner, _React$Component);

  function CookieBanner(props) {
    _classCallCheck(this, CookieBanner);

    var _this = _possibleConstructorReturn(this, (CookieBanner.__proto__ || Object.getPrototypeOf(CookieBanner)).call(this, props));

    _this.state = {
      userAgreed: undefined,
      loading: true
    };

    _this.handleButtonClick = _this.handleButtonClick.bind(_this);
    return _this;
  }

  _createClass(CookieBanner, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.setState({
        userAgreed: UserAgreedStore.get(),
        loading: false
      });
    }
  }, {
    key: 'handleButtonClick',
    value: function handleButtonClick() {
      UserAgreedStore.set(true);
      this.setState({ userAgreed: true });
    }
  }, {
    key: 'render',
    value: function render() {
      var _state = this.state,
          loading = _state.loading,
          userAgreed = _state.userAgreed;

      return loading || userAgreed ? null : __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { style: bannerStyle },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          null,
          'This website requires cookies & limited processing of your personal data in order to function properly. By clicking any link on this page you are giving your consent to this as outlined in our ',
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'a',
            { style: linkStyle, target: '_blank', href: privacyPolicyLink },
            'Privacy Policy'
          ),
          '.'
        ),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          null,
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'div',
            null,
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'button',
              { style: linkStyle, type: 'button', onClick: this.handleButtonClick, className: 'wdk-Link' },
              'I agree & close this banner.'
            )
          ),
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'div',
            { style: { marginTop: '.5em' } },
            __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
              'a',
              { style: linkStyle, target: '_blank', href: privacyPolicyLink },
              'More info.'
            )
          )
        )
      );
    }
  }]);

  return CookieBanner;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.Component);

/* harmony default export */ __webpack_exports__["default"] = (CookieBanner);

/***/ }),
/* 41 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_IterableUtils__ = __webpack_require__(13);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_IterableUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_IterableUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__QuestionWizard__ = __webpack_require__(15);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__Parameters__ = __webpack_require__(44);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__util_classNames__ = __webpack_require__(42);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__util_QuestionWizardState__ = __webpack_require__(43);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__);









/**
 * Active group section. Includes heading, help text, summary counts, and parameters.
 */
function ActiveGroup(props) {
  if (props.wizardState.activeGroup == null) return null;

  var _props$wizardState = props.wizardState,
      question = _props$wizardState.question,
      paramValues = _props$wizardState.paramValues,
      paramUIState = _props$wizardState.paramUIState,
      groupUIState = _props$wizardState.groupUIState,
      recordClass = _props$wizardState.recordClass,
      activeGroup = _props$wizardState.activeGroup,
      initialCount = _props$wizardState.initialCount,
      _props$eventHandlers = props.eventHandlers,
      setActiveOntologyTerm = _props$eventHandlers.setActiveOntologyTerm,
      setOntologyTermSort = _props$eventHandlers.setOntologyTermSort,
      setOntologyTermSearch = _props$eventHandlers.setOntologyTermSearch,
      setParamValue = _props$eventHandlers.setParamValue,
      setParamState = _props$eventHandlers.setParamState;


  var paramMap = new Map(question.parameters.map(function (p) {
    return [p.name, p];
  }));
  var _groupUIState$activeG = groupUIState[activeGroup.name],
      accumulatedTotal = _groupUIState$activeG.accumulatedTotal,
      loading = _groupUIState$activeG.loading;

  var _Seq$of$concat$last = __WEBPACK_IMPORTED_MODULE_1_wdk_client_IterableUtils__["Seq"].of({ accumulatedTotal: initialCount }).concat(__WEBPACK_IMPORTED_MODULE_1_wdk_client_IterableUtils__["Seq"].from(question.groups).takeWhile(function (group) {
    return group !== activeGroup;
  }).map(function (group) {
    return groupUIState[group.name];
  })).last(),
      prevAccumulatedTotal = _Seq$of$concat$last.accumulatedTotal,
      prevLoading = _Seq$of$concat$last.loading;

  var parameters = activeGroup.parameters.map(function (paramName) {
    return paramMap.get(paramName);
  }).filter(function (param) {
    return param.isVisible;
  });

  var loadingEl = React.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["Loading"], { radius: 2, className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('GroupLoading') });

  return React.createElement(
    'div',
    { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupContainer') },
    React.createElement(
      'div',
      { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupHeading') },
      Object(__WEBPACK_IMPORTED_MODULE_6__util_QuestionWizardState__["e" /* groupParamsValuesAreDefault */])(props.wizardState, activeGroup) ? React.createElement(
        'div',
        { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupCount') },
        'No ',
        React.createElement(
          'em',
          null,
          activeGroup.displayName
        ),
        ' filters applied yet'
      ) : React.createElement(
        'div',
        { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupCount') },
        'Your ',
        React.createElement(
          'em',
          null,
          activeGroup.displayName
        ),
        ' filters reduce ',
        prevLoading ? loadingEl : Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["result"])(prevAccumulatedTotal, 'toLocaleString'),
        ' ',
        recordClass.displayNamePlural,
        ' to ',
        loading ? loadingEl : Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["result"])(accumulatedTotal, 'toLocaleString')
      ),
      activeGroup.description && React.createElement(
        'div',
        { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ActiveGroupDescription') },
        activeGroup.description
      )
    ),
    React.createElement(__WEBPACK_IMPORTED_MODULE_4__Parameters__["default"], {
      group: activeGroup,
      parameters: parameters,
      paramValues: paramValues,
      paramUIState: paramUIState,
      onActiveOntologyTermChange: setActiveOntologyTerm,
      onOntologyTermSort: setOntologyTermSort,
      onOntologyTermSearch: setOntologyTermSearch,
      onParamValueChange: setParamValue,
      onParamStateChange: setParamState
    })
  );
}

ActiveGroup.propTypes = __WEBPACK_IMPORTED_MODULE_3__QuestionWizard__["propTypes"];

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__["wrappable"])(ActiveGroup));

/***/ }),
/* 42 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* unused harmony export classNameHelper */
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return makeQuestionWizardClassName; });
/**
 * Create a classes string generator that follows a BEM convention.
 *
 * @example
 * ```
 * const makeClassName = classNameHelper('Ebrc')
 * makeClassName() //=> 'Ebrc'
 * makeClassName('Hello') //=> 'EbrcHello'
 * makeClassName('Hello', 'green') //=> 'EbrcHello EbrcHello__green'
 * makeClassName('Hello', 'red', 'muted') //=> 'EbrcHello EbrcHello__red EbrcHello__muted'
 * ```
 * @param {string} baseClassName The root string to prepend to all variants.
 * @param {string} element Suffix to append to baseClassName.
 * @param {string[]} ...modifiers Variants to append to classNames
 */
var classNameHelper = function classNameHelper(baseClassName) {
  return function () {
    for (var _len = arguments.length, modifiers = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
      modifiers[_key - 1] = arguments[_key];
    }

    var element = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '';

    var className = baseClassName + element;
    var modifiedClassNames = modifiers.filter(function (modifier) {
      return modifier;
    }).map(function (modifier) {
      return ' ' + className + '__' + modifier;
    }).join('');

    return className + modifiedClassNames;
  };
};

var makeQuestionWizardClassName = classNameHelper('ebrc-QuestionWizard');

/***/ }),
/* 43 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = createInitialState;
/* harmony export (immutable) */ __webpack_exports__["b"] = getDefaultParamValues;
/* harmony export (immutable) */ __webpack_exports__["e"] = groupParamsValuesAreDefault;
/* unused harmony export getGroup */
/* harmony export (immutable) */ __webpack_exports__["c"] = getParameter;
/* harmony export (immutable) */ __webpack_exports__["d"] = getParameterValuesForGroup;
/* harmony export (immutable) */ __webpack_exports__["h"] = setFilterPopupVisiblity;
/* harmony export (immutable) */ __webpack_exports__["g"] = setFilterPopupPinned;
/* harmony export (immutable) */ __webpack_exports__["f"] = resetParamValues;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_FilterServiceUtils__ = __webpack_require__(59);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_FilterServiceUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_FilterServiceUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__ = __webpack_require__(18);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__);
var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

function _toArray(arr) { return Array.isArray(arr) ? arr : Array.from(arr); }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Wizard state utility functions





/**
 * Create initial wizard state object
 */
function createInitialState(question, recordClass, paramValues) {

  var paramUIState = question.parameters.reduce(function (uiState, param) {
    switch (param.type) {
      case 'FilterParamNew':
        {
          var leaves = Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__["getLeaves"])(Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_FilterServiceUtils__["getTree"])(param.ontology), function (node) {
            return node.children;
          });
          var ontology = param.values == null ? param.ontology : param.ontology.map(function (entry) {
            return param.values[entry.term] == null ? entry : Object.assign(entry, {
              values: param.values[entry.term].join(' ')
            });
          });
          return Object.assign(uiState, _defineProperty({}, param.name, {
            ontology: ontology,
            activeOntologyTerm: leaves.length > 0 ? leaves[0].field.term : null,
            hideFilterPanel: leaves.length === 1,
            hideFieldPanel: leaves.length === 1,
            ontologyTermSummaries: {},
            fieldStates: {},
            defaultMemberFieldState: {
              sort: {
                columnKey: 'value',
                direction: 'asc',
                groupBySelected: false
              },
              searchTerm: ''
            },
            defaultRangeFieldState: {}
          }));
        }

      case 'FlatVocabParam':
      case 'EnumParam':
        return Object.assign(uiState, _defineProperty({}, param.name, {
          vocabulary: param.vocabulary
        }));

      default:
        return Object.assign(uiState, _defineProperty({}, param.name, {}));
    }
  }, {});

  var groupUIState = question.groups.reduce(function (groupUIState, group) {
    return Object.assign(groupUIState, _defineProperty({}, group.name, {
      accumulatedTotal: undefined,
      valid: undefined,
      loading: false
    }));
  }, {});

  var filterPopupState = {
    visible: false,
    pinned: false
  };

  return {
    question: question,
    paramValues: paramValues,
    paramUIState: paramUIState,
    groupUIState: groupUIState,
    filterPopupState: filterPopupState,
    recordClass: recordClass,
    activeGroup: undefined
  };
}

/**
 * Get the default parameter values
 * @param {WizardState} wizardState
 * @return {Record<string, string>}
 */
function getDefaultParamValues(wizardState) {
  return wizardState.question.parameters.reduce(function (defaultParamValues, param) {
    return Object.assign(defaultParamValues, _defineProperty({}, param.name, param.defaultValue));
  }, {});
}

/**
 * Determine if the parameters of a given group have their default value.
 * @param {WizardState} wizardState
 * @param {Group} group
 * @return {boolean}
 */
function groupParamsValuesAreDefault(wizardState, group) {
  var defaultValues = getDefaultParamValues(wizardState);
  return group.parameters.every(function (paramName) {
    return wizardState.paramValues[paramName] === defaultValues[paramName];
  });
}

function getGroup(wizardState, groupName) {
  return getGroupMap(wizardState.question).get(groupName);
}

function getParameter(wizardState, paramName) {
  return getParamMap(wizardState.question).get(paramName);
}

/**
 * Get the set of parameters for a given group.
 */
function getParameterValuesForGroup(wizardState, groupName) {
  var group = getGroup(wizardState, groupName);
  return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["pick"])(wizardState.paramValues, group.parameters);
}

var getGroupMap = Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["memoize"])(function (question) {
  return new Map(question.groups.map(function (g) {
    return [g.name, g];
  }));
});
var getParamMap = Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["memoize"])(function (question) {
  return new Map(question.parameters.map(function (p) {
    return [p.name, p];
  }));
});

// Immutable state modifiers
// -------------------------

/**
 * Show or hide popup with filter summary.
 * @param {WizardState} wizardState
 * @param {boolean} visiblity
 * @return {WizardState}
 */
function setFilterPopupVisiblity(wizardState, visible) {
  return updateObjectImmutably(wizardState, ['filterPopupState', 'visible'], visible);
}

/**
 * Set if filter popup should hide when navigation elements are clicked
 * @param {WizardState} wizardState
 * @param {boolean} pinned
 * @return {WizardState}
 */
function setFilterPopupPinned(wizardState, pinned) {
  return updateObjectImmutably(wizardState, ['filterPopupState', 'pinned'], pinned);
}

/**
 * Update paramValues with defaults.
 * @param {WizardState} wizardState
 * @return {WizardState}
 */
function resetParamValues(wizardState) {
  return updateObjectImmutably(wizardState, ['paramValues'], getDefaultParamValues(wizardState));
}

/**
 * Creates a new object based on input object with an updated value
 * a the specified path.
 */
function updateObjectImmutably(object, _ref, value) {
  var _ref2 = _toArray(_ref),
      key = _ref2[0],
      restPath = _ref2.slice(1);

  var isObject = (typeof object === 'undefined' ? 'undefined' : _typeof(object)) === 'object';
  if (!isObject || isObject && !(key in object)) throw new Error("Invalid key path");

  return Object.assign({}, object, _defineProperty({}, key, restPath.length === 0 ? value : updateObjectImmutably(object[key], restPath, value)));
}

/***/ }),
/* 44 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__Param__ = __webpack_require__(45);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__util_classNames__ = __webpack_require__(42);







/**
 * Parameters that belong to a Paramter group
 */
function Parameters(props) {
  var parameters = props.parameters,
      paramValues = props.paramValues,
      paramUIState = props.paramUIState,
      onActiveOntologyTermChange = props.onActiveOntologyTermChange,
      onOntologyTermSort = props.onOntologyTermSort,
      onOntologyTermSearch = props.onOntologyTermSearch,
      onParamValueChange = props.onParamValueChange,
      onParamStateChange = props.onParamStateChange;

  var showLabel = parameters.length > 1;
  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    'div',
    { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamContainer') },
    parameters.map(function (param) {
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { key: param.name, className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('Param', param.type) },
        showLabel && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamLabel', param.type) },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            'label',
            null,
            param.displayName
          )
        ),
        showLabel && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          { className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamHelp', param.type) },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
            __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["HelpIcon"],
            null,
            param.help
          )
        ),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'div',
          {
            className: Object(__WEBPACK_IMPORTED_MODULE_5__util_classNames__["a" /* makeQuestionWizardClassName */])('ParamControl', param.type),
            onKeyPress: function onKeyPress(event) {
              // Prevent form submission of ENTER is pressed while an input
              // field has focus. This is a hack and may bite us in the future
              // if we have param widgets that depend on the user agent's
              // default handling of the event.
              //
              // FIXME Handle this in a more robust manner.
              // The reason we do it this way is that the question wizard is
              // embedded inside of the classic WDK question form, which may
              // or may not use an inline submit handler, depending on the
              // context. The question wizard needs more control over the form
              // element in order to do the following in a more robust manner.
              if (event.target instanceof HTMLInputElement && event.key === 'Enter') {
                event.preventDefault();
              }
            }
          },
          __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_4__Param__["default"], {
            param: param,
            value: paramValues[param.name],
            uiState: paramUIState[param.name],
            onActiveOntologyTermChange: onActiveOntologyTermChange,
            onOntologyTermSort: onOntologyTermSort,
            onOntologyTermSearch: onOntologyTermSearch,
            onParamValueChange: onParamValueChange,
            onParamStateChange: onParamStateChange
          })
        )
      );
    })
  );
}

Parameters.propTypes = {
  group: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  parameters: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.array.isRequired,
  paramValues: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  paramUIState: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.object.isRequired,
  onActiveOntologyTermChange: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  onOntologyTermSort: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  onOntologyTermSearch: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  onParamValueChange: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired,
  onParamStateChange: __WEBPACK_IMPORTED_MODULE_1_prop_types___default.a.func.isRequired
};

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ComponentUtils__["wrappable"])(Parameters));

/***/ }),
/* 45 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__FilterParamNew__ = __webpack_require__(46);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__FlatVocabParam__ = __webpack_require__(47);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__StringParam__ = __webpack_require__(48);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__DateParam__ = __webpack_require__(49);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__DateRangeParam__ = __webpack_require__(50);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__NumberParam__ = __webpack_require__(51);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__NumberRangeParam__ = __webpack_require__(52);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_9__util_paramUtil__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_10_wdk_client_ComponentUtils__);












/**
 * Param component
 */
function Param(props) {
  var ParamComponent = props.findParamComponent(props.param);
  if (ParamComponent == null) {
    return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
      'div',
      null,
      props.param.displayName,
      ' ',
      props.param.defaultValue
    );
  }
  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(ParamComponent, props);
}

Param.defaultProps = {
  findParamComponent: findParamComponent
};

/**
 * Lookup Param component by param type
 */
function findParamComponent(param) {
  switch (param.type) {
    case 'FilterParamNew':
      return __WEBPACK_IMPORTED_MODULE_2__FilterParamNew__["default"];
    case 'StringParam':
      return __WEBPACK_IMPORTED_MODULE_4__StringParam__["default"];
    case 'EnumParam':
      return __WEBPACK_IMPORTED_MODULE_3__FlatVocabParam__["default"];
    case 'FlatVocabParam':
      return __WEBPACK_IMPORTED_MODULE_3__FlatVocabParam__["default"];
    case 'DateParam':
      return __WEBPACK_IMPORTED_MODULE_5__DateParam__["default"];
    case 'DateRangeParam':
      return __WEBPACK_IMPORTED_MODULE_6__DateRangeParam__["default"];
    case 'NumberParam':
      return __WEBPACK_IMPORTED_MODULE_7__NumberParam__["default"];
    case 'NumberRangeParam':
      return __WEBPACK_IMPORTED_MODULE_8__NumberRangeParam__["default"];
    default:
      return null;
  }
}

Param.propTypes = __WEBPACK_IMPORTED_MODULE_9__util_paramUtil__["paramPropTypes"];

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_10_wdk_client_ComponentUtils__["wrappable"])(Param));

/***/ }),
/* 46 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3__util_paramUtil__);
var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }






/**
 * FilterParamNew component
 */

var FilterParamNew = function (_React$PureComponent) {
  _inherits(FilterParamNew, _React$PureComponent);

  function FilterParamNew(props) {
    _classCallCheck(this, FilterParamNew);

    var _this = _possibleConstructorReturn(this, (FilterParamNew.__proto__ || Object.getPrototypeOf(FilterParamNew)).call(this, props));

    _this._getFiltersFromValue = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["memoize"])(_this._getFiltersFromValue);
    _this._getFieldMap = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["memoize"])(_this._getFieldMap);
    _this._handleActiveFieldChange = _this._handleActiveFieldChange.bind(_this);
    _this._handleFilterChange = _this._handleFilterChange.bind(_this);
    _this._handleMemberSort = _this._handleMemberSort.bind(_this);
    _this._handleMemberSearch = _this._handleMemberSearch.bind(_this);
    _this._handleRangeScaleChange = _this._handleRangeScaleChange.bind(_this);
    return _this;
  }

  _createClass(FilterParamNew, [{
    key: '_getFiltersFromValue',
    value: function _getFiltersFromValue(value) {
      var _JSON$parse = JSON.parse(value),
          _JSON$parse$filters = _JSON$parse.filters,
          filters = _JSON$parse$filters === undefined ? [] : _JSON$parse$filters;

      return filters;
    }
  }, {
    key: '_getFieldMap',
    value: function _getFieldMap(ontology) {
      return new Map(ontology.map(function (o) {
        return [o.term, o];
      }));
    }
  }, {
    key: '_handleActiveFieldChange',
    value: function _handleActiveFieldChange(term) {
      var filters = this._getFiltersFromValue(this.props.value);
      this.props.onActiveOntologyTermChange(this.props.param, filters, term);
    }
  }, {
    key: '_handleFilterChange',
    value: function _handleFilterChange(filters) {
      var fieldMap = this._getFieldMap(this.props.param.ontology);
      var filtersWithDisplay = filters.map(function (filter) {
        var field = fieldMap.get(filter.field);
        var fieldDisplayName = field ? field.display : undefined;
        return _extends({}, filter, { fieldDisplayName: fieldDisplayName });
      });
      this.props.onParamValueChange(this.props.param, JSON.stringify({ filters: filtersWithDisplay }));
    }
  }, {
    key: '_handleMemberSort',
    value: function _handleMemberSort(field, sort) {
      this.props.onOntologyTermSort(this.props.param, field.term, sort);
    }
  }, {
    key: '_handleMemberSearch',
    value: function _handleMemberSearch(field, searchTerm) {
      this.props.onOntologyTermSearch(this.props.param, field.term, searchTerm);
    }
  }, {
    key: '_handleRangeScaleChange',
    value: function _handleRangeScaleChange(field, state) {
      var newState = Object.assign({}, this.props.uiState, {
        fieldStates: Object.assign({}, this.props.uiState.fieldStates, _defineProperty({}, field.term, state))
      });
      this.props.onParamStateChange(this.props.param, newState);
    }
  }, {
    key: 'render',
    value: function render() {
      var _props = this.props,
          param = _props.param,
          uiState = _props.uiState;

      var fields = this._getFieldMap(uiState.ontology);
      var filters = this._getFiltersFromValue(this.props.value);
      var activeField = fields.get(uiState.activeOntologyTerm);
      var activeFieldState = uiState.fieldStates[uiState.activeOntologyTerm];
      var activeFieldSummary = uiState.ontologyTermSummaries[uiState.activeOntologyTerm];

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: 'filter-param' },
        uiState.errorMessage && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
          'pre',
          { style: { color: 'red' } },
          uiState.errorMessage
        ),
        uiState.loading && __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["Loading"], null),
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["ServerSideAttributeFilter"], {
          autoFocus: this.props.autoFocus,
          displayName: param.filterDataTypeDisplayName || param.displayName,

          fields: fields,
          filters: filters,
          dataCount: uiState.unfilteredCount,
          filteredDataCount: uiState.filteredCount,

          activeField: activeField,
          activeFieldState: activeFieldState,
          activeFieldSummary: activeFieldSummary,

          hideFilterPanel: uiState.hideFilterPanel,
          hideFieldPanel: uiState.hideFieldPanel,

          onFiltersChange: this._handleFilterChange,
          onActiveFieldChange: this._handleActiveFieldChange,
          onMemberSort: this._handleMemberSort,
          onMemberSearch: this._handleMemberSearch,
          onRangeScaleChange: this._handleRangeScaleChange,
          hideGlobalCounts: true
        })
      );
    }
  }]);

  return FilterParamNew;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (FilterParamNew);


FilterParamNew.propTypes = __WEBPACK_IMPORTED_MODULE_3__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 47 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (immutable) */ __webpack_exports__["default"] = FlatVocabParam;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__util_paramUtil__);



/**
 * FlatVocabParam component. Currently only supports single select.
 * FIXME Handle all param options.
 */
function FlatVocabParam(props) {
  return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
    'select',
    {
      onChange: function onChange(event) {
        return props.onParamValueChange(props.param, event.target.value);
      },
      value: props.value,
      multiple: props.param.multiPick
    },
    props.uiState.vocabulary.map(function (entry) {
      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'option',
        { key: entry[0], value: entry[0] },
        entry[1]
      );
    })
  );
}

FlatVocabParam.propTypes = __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 48 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__util_paramUtil__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }




/**
 * StringParam component
 */

var StringParam = function (_React$PureComponent) {
  _inherits(StringParam, _React$PureComponent);

  function StringParam(props) {
    _classCallCheck(this, StringParam);

    var _this = _possibleConstructorReturn(this, (StringParam.__proto__ || Object.getPrototypeOf(StringParam)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    _this.handleBlur = _this.handleBlur.bind(_this);
    _this.state = { pendingValue: props.value };
    return _this;
  }

  _createClass(StringParam, [{
    key: 'handleChange',
    value: function handleChange(event) {
      this.setState({
        pendingValue: event.currentTarget.value
      });
    }
  }, {
    key: 'handleBlur',
    value: function handleBlur() {
      if (this.state.pendingValue !== this.props.value) this.props.onParamValueChange(this.props.param, this.state.pendingValue);
    }
  }, {
    key: 'componentWillReceiveProps',
    value: function componentWillReceiveProps(nextProps) {
      if (nextProps.value !== this.props.value) this.setState({ pendingValue: nextProps.value });
    }
  }, {
    key: 'render',
    value: function render() {
      var pendingValue = this.state.pendingValue;
      var autoFocus = this.props.autoFocus;

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement('input', {
        type: 'text',
        value: pendingValue,
        onChange: this.handleChange,
        onBlur: this.handleBlur,
        autoFocus: autoFocus
      });
    }
  }]);

  return StringParam;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (StringParam);


StringParam.propTypes = __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 49 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2__util_paramUtil__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }





/**
 * DateParam component
 */

var DateParam = function (_React$PureComponent) {
  _inherits(DateParam, _React$PureComponent);

  function DateParam(props) {
    _classCallCheck(this, DateParam);

    var _this = _possibleConstructorReturn(this, (DateParam.__proto__ || Object.getPrototypeOf(DateParam)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    return _this;
  }

  _createClass(DateParam, [{
    key: 'handleChange',
    value: function handleChange(newValue) {
      var _props = this.props,
          param = _props.param,
          onParamValueChange = _props.onParamValueChange;

      onParamValueChange(param, newValue);
    }
  }, {
    key: 'render',
    value: function render() {
      var _props2 = this.props,
          param = _props2.param,
          value = _props2.value;
      var minDate = param.minDate,
          maxDate = param.maxDate;

      value = JSON.parse(value);

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: 'date-param' },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["DateSelector"], {
          value: value,
          start: minDate,
          end: maxDate,
          onChange: this.handleChange
        })
      );
    }
  }]);

  return DateParam;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (DateParam);


DateParam.propTypes = __WEBPACK_IMPORTED_MODULE_2__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 50 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__util_paramUtil__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }





/**
 * DateRange param
*/

var DateRangeParam = function (_React$PureComponent) {
  _inherits(DateRangeParam, _React$PureComponent);

  function DateRangeParam(props) {
    _classCallCheck(this, DateRangeParam);

    var _this = _possibleConstructorReturn(this, (DateRangeParam.__proto__ || Object.getPrototypeOf(DateRangeParam)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    return _this;
  }

  _createClass(DateRangeParam, [{
    key: 'handleChange',
    value: function handleChange(newValue) {
      var _props = this.props,
          param = _props.param,
          onParamValueChange = _props.onParamValueChange;

      newValue = JSON.stringify(newValue);
      onParamValueChange(param, newValue);
    }
  }, {
    key: 'render',
    value: function render() {
      var _props2 = this.props,
          param = _props2.param,
          value = _props2.value;
      var minDate = param.minDate,
          maxDate = param.maxDate;

      value = JSON.parse(value);

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: 'date-range-param' },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["DateRangeSelector"], {
          value: value,
          start: minDate,
          end: maxDate,
          onChange: this.handleChange
        })
      );
    }
  }]);

  return DateRangeParam;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (DateRangeParam);


DateRangeParam.propTypes = __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 51 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__util_paramUtil__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }






/**
 * Number parameters
 */

var NumberParam = function (_React$PureComponent) {
  _inherits(NumberParam, _React$PureComponent);

  function NumberParam(props) {
    _classCallCheck(this, NumberParam);

    var _this = _possibleConstructorReturn(this, (NumberParam.__proto__ || Object.getPrototypeOf(NumberParam)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    return _this;
  }

  _createClass(NumberParam, [{
    key: 'handleChange',
    value: function handleChange(newValue) {
      var _props = this.props,
          param = _props.param,
          onParamValueChange = _props.onParamValueChange;

      onParamValueChange(param, String(newValue));
    }
  }, {
    key: 'render',
    value: function render() {
      var _props2 = this.props,
          param = _props2.param,
          value = _props2.value;
      var min = param.min,
          max = param.max,
          integer = param.integer,
          step = param.step;

      var numberValue = Number(value);
      var stepValue = step != null ? Number(step) : integer !== 'false' ? 1 : 0.01;

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: 'number-param' },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["NumberSelector"], {
          value: numberValue,
          start: min,
          end: max,
          step: stepValue,
          onChange: this.handleChange
        })
      );
    }
  }]);

  return NumberParam;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (NumberParam);


NumberParam.propTypes = __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 52 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__ = __webpack_require__(7);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_paramUtil___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1__util_paramUtil__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }





/**
 * NumberRangeParam component
 */

var NumberRangeParam = function (_React$PureComponent) {
  _inherits(NumberRangeParam, _React$PureComponent);

  function NumberRangeParam(props) {
    _classCallCheck(this, NumberRangeParam);

    var _this = _possibleConstructorReturn(this, (NumberRangeParam.__proto__ || Object.getPrototypeOf(NumberRangeParam)).call(this, props));

    _this.handleChange = _this.handleChange.bind(_this);
    return _this;
  }

  _createClass(NumberRangeParam, [{
    key: 'handleChange',
    value: function handleChange(newValue) {
      var _props = this.props,
          param = _props.param,
          onParamValueChange = _props.onParamValueChange;

      onParamValueChange(param, JSON.stringify({
        min: String(newValue.min),
        max: String(newValue.max)
      }));
    }
  }, {
    key: 'parseValue',
    value: function parseValue(value) {
      var _JSON$parse = JSON.parse(value),
          min = _JSON$parse.min,
          max = _JSON$parse.max;

      return {
        min: Number(min),
        max: Number(max)
      };
    }
  }, {
    key: 'render',
    value: function render() {
      var _props2 = this.props,
          param = _props2.param,
          value = _props2.value;
      var min = param.min,
          max = param.max,
          integer = param.integer,
          step = param.step;

      var parsedValue = this.parseValue(value);
      var stepValue = step != null ? Number(step) : integer !== 'false' ? 1 : 0.01;

      if (step) step = step * 1;else step = !integer || integer === 'false' ? 0.01 : 1;

      return __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(
        'div',
        { className: 'number-range-param' },
        __WEBPACK_IMPORTED_MODULE_0_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Components__["NumberRangeSelector"], {
          value: parsedValue,
          start: min,
          end: max,
          step: stepValue,
          onChange: this.handleChange
        })
      );
    }
  }]);

  return NumberRangeParam;
}(__WEBPACK_IMPORTED_MODULE_0_react___default.a.PureComponent);

/* harmony default export */ __webpack_exports__["default"] = (NumberRangeParam);


NumberRangeParam.propTypes = __WEBPACK_IMPORTED_MODULE_1__util_paramUtil__["paramPropTypes"];

/***/ }),
/* 53 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Controllers__ = __webpack_require__(16);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_Controllers___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Controllers__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }






var TreeDataViewer = function (_Component) {
  _inherits(TreeDataViewer, _Component);

  function TreeDataViewer(props) {
    _classCallCheck(this, TreeDataViewer);

    var _this = _possibleConstructorReturn(this, (TreeDataViewer.__proto__ || Object.getPrototypeOf(TreeDataViewer)).call(this, props));

    _this.state = {
      text: "",
      expandedNodes: [],
      searchTerm: ""
    };
    Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["bindAll"])(_this, ['onTextChange', 'onExpansionChange', 'onSearchTermChange']);
    return _this;
  }

  // event handlers update individual state values


  _createClass(TreeDataViewer, [{
    key: 'onTextChange',
    value: function onTextChange(event) {
      update(this, { text: event.target.value });
    }
  }, {
    key: 'onExpansionChange',
    value: function onExpansionChange(expandedNodes) {
      update(this, { expandedNodes: expandedNodes });
    }
  }, {
    key: 'onSearchTermChange',
    value: function onSearchTermChange(searchTerm) {
      update(this, { searchTerm: searchTerm });
    }
  }, {
    key: 'render',
    value: function render() {
      var display = "";
      if (this.state.text != "") {
        try {
          var parsedTree = JSON.parse(this.state.text);
          display = React.createElement(__WEBPACK_IMPORTED_MODULE_3_wdk_client_Components__["CheckboxTree"], {
            tree: parsedTree,
            getNodeId: function getNodeId(node) {
              return node.id;
            },
            getNodeChildren: function getNodeChildren(node) {
              return node.children ? node.children : [];
            },
            onExpansionChange: this.onExpansionChange,
            showRoot: true,
            nodeComponent: function nodeComponent(props) {
              return React.createElement(
                'span',
                null,
                props.node.display
              );
            },
            expandedList: this.state.expandedNodes,
            isSelectable: false,
            selectedList: [],
            isSearchable: true,
            searchBoxPlaceholder: 'Search...',
            searchBoxHelp: 'Search the structure below',
            searchTerm: this.state.searchTerm,
            onSearchTermChange: this.onSearchTermChange,
            searchPredicate: isNodeInSearch });
        } catch (e) {
          display = React.createElement(
            'span',
            null,
            e.message
          );
        }
      }
      return React.createElement(
        'div',
        null,
        React.createElement(
          'h3',
          null,
          'Tree Data Viewer'
        ),
        React.createElement(
          'p',
          null,
          'Enter a tree of data in JSON format, where a Node is ',
          "{ id:String, display:String, children:Array[Node] }",
          '.'
        ),
        React.createElement(
          'p',
          null,
          React.createElement('textarea', { value: this.state.text, onChange: this.onTextChange })
        ),
        React.createElement(
          'div',
          null,
          display
        )
      );
    }
  }]);

  return TreeDataViewer;
}(__WEBPACK_IMPORTED_MODULE_0_react__["Component"]);

function isNodeInSearch(node, terms) {
  return terms.map(function (term) {
    return term.toLowerCase();
  }).some(function (term) {
    return node.id.toLowerCase().includes(term) || node.display.toLowerCase().includes(term);
  });
}

function update(stateContainer, changedState) {
  stateContainer.setState(Object.assign(stateContainer.state, changedState));
}

var TreeDataViewerController = function (_WdkPageController) {
  _inherits(TreeDataViewerController, _WdkPageController);

  function TreeDataViewerController() {
    _classCallCheck(this, TreeDataViewerController);

    return _possibleConstructorReturn(this, (TreeDataViewerController.__proto__ || Object.getPrototypeOf(TreeDataViewerController)).apply(this, arguments));
  }

  _createClass(TreeDataViewerController, [{
    key: 'getTitle',
    value: function getTitle() {
      return "Tree Data Viewer";
    }
  }, {
    key: 'renderView',
    value: function renderView() {
      return React.createElement(TreeDataViewer, this.props);
    }
  }]);

  return TreeDataViewerController;
}(__WEBPACK_IMPORTED_MODULE_2_wdk_client_Controllers__["WdkPageController"]);

/* harmony default export */ __webpack_exports__["default"] = (TreeDataViewerController);

/***/ }),
/* 54 */
/***/ (function(module, exports) {

module.exports = Wdk.OntologyUtils;

/***/ }),
/* 55 */
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(global, process, console) {// Copyright Joyent, Inc. and other Node contributors.
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
// NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.

var formatRegExp = /%[sdj%]/g;
exports.format = function(f) {
  if (!isString(f)) {
    var objects = [];
    for (var i = 0; i < arguments.length; i++) {
      objects.push(inspect(arguments[i]));
    }
    return objects.join(' ');
  }

  var i = 1;
  var args = arguments;
  var len = args.length;
  var str = String(f).replace(formatRegExp, function(x) {
    if (x === '%%') return '%';
    if (i >= len) return x;
    switch (x) {
      case '%s': return String(args[i++]);
      case '%d': return Number(args[i++]);
      case '%j':
        try {
          return JSON.stringify(args[i++]);
        } catch (_) {
          return '[Circular]';
        }
      default:
        return x;
    }
  });
  for (var x = args[i]; i < len; x = args[++i]) {
    if (isNull(x) || !isObject(x)) {
      str += ' ' + x;
    } else {
      str += ' ' + inspect(x);
    }
  }
  return str;
};


// Mark that a method should not be used.
// Returns a modified function which warns once by default.
// If --no-deprecation is set, then it is a no-op.
exports.deprecate = function(fn, msg) {
  // Allow for deprecating things in the process of starting up.
  if (isUndefined(global.process)) {
    return function() {
      return exports.deprecate(fn, msg).apply(this, arguments);
    };
  }

  if (process.noDeprecation === true) {
    return fn;
  }

  var warned = false;
  function deprecated() {
    if (!warned) {
      if (process.throwDeprecation) {
        throw new Error(msg);
      } else if (process.traceDeprecation) {
        console.trace(msg);
      } else {
        console.error(msg);
      }
      warned = true;
    }
    return fn.apply(this, arguments);
  }

  return deprecated;
};


var debugs = {};
var debugEnviron;
exports.debuglog = function(set) {
  if (isUndefined(debugEnviron))
    debugEnviron = Object({"NODE_ENV":"development"}).NODE_DEBUG || '';
  set = set.toUpperCase();
  if (!debugs[set]) {
    if (new RegExp('\\b' + set + '\\b', 'i').test(debugEnviron)) {
      var pid = process.pid;
      debugs[set] = function() {
        var msg = exports.format.apply(exports, arguments);
        console.error('%s %d: %s', set, pid, msg);
      };
    } else {
      debugs[set] = function() {};
    }
  }
  return debugs[set];
};


/**
 * Echos the value of a value. Trys to print the value out
 * in the best way possible given the different types.
 *
 * @param {Object} obj The object to print out.
 * @param {Object} opts Optional options object that alters the output.
 */
/* legacy: obj, showHidden, depth, colors*/
function inspect(obj, opts) {
  // default options
  var ctx = {
    seen: [],
    stylize: stylizeNoColor
  };
  // legacy...
  if (arguments.length >= 3) ctx.depth = arguments[2];
  if (arguments.length >= 4) ctx.colors = arguments[3];
  if (isBoolean(opts)) {
    // legacy...
    ctx.showHidden = opts;
  } else if (opts) {
    // got an "options" object
    exports._extend(ctx, opts);
  }
  // set default options
  if (isUndefined(ctx.showHidden)) ctx.showHidden = false;
  if (isUndefined(ctx.depth)) ctx.depth = 2;
  if (isUndefined(ctx.colors)) ctx.colors = false;
  if (isUndefined(ctx.customInspect)) ctx.customInspect = true;
  if (ctx.colors) ctx.stylize = stylizeWithColor;
  return formatValue(ctx, obj, ctx.depth);
}
exports.inspect = inspect;


// http://en.wikipedia.org/wiki/ANSI_escape_code#graphics
inspect.colors = {
  'bold' : [1, 22],
  'italic' : [3, 23],
  'underline' : [4, 24],
  'inverse' : [7, 27],
  'white' : [37, 39],
  'grey' : [90, 39],
  'black' : [30, 39],
  'blue' : [34, 39],
  'cyan' : [36, 39],
  'green' : [32, 39],
  'magenta' : [35, 39],
  'red' : [31, 39],
  'yellow' : [33, 39]
};

// Don't use 'blue' not visible on cmd.exe
inspect.styles = {
  'special': 'cyan',
  'number': 'yellow',
  'boolean': 'yellow',
  'undefined': 'grey',
  'null': 'bold',
  'string': 'green',
  'date': 'magenta',
  // "name": intentionally not styling
  'regexp': 'red'
};


function stylizeWithColor(str, styleType) {
  var style = inspect.styles[styleType];

  if (style) {
    return '\u001b[' + inspect.colors[style][0] + 'm' + str +
           '\u001b[' + inspect.colors[style][1] + 'm';
  } else {
    return str;
  }
}


function stylizeNoColor(str, styleType) {
  return str;
}


function arrayToHash(array) {
  var hash = {};

  array.forEach(function(val, idx) {
    hash[val] = true;
  });

  return hash;
}


function formatValue(ctx, value, recurseTimes) {
  // Provide a hook for user-specified inspect functions.
  // Check that value is an object with an inspect function on it
  if (ctx.customInspect &&
      value &&
      isFunction(value.inspect) &&
      // Filter out the util module, it's inspect function is special
      value.inspect !== exports.inspect &&
      // Also filter out any prototype objects using the circular check.
      !(value.constructor && value.constructor.prototype === value)) {
    var ret = value.inspect(recurseTimes, ctx);
    if (!isString(ret)) {
      ret = formatValue(ctx, ret, recurseTimes);
    }
    return ret;
  }

  // Primitive types cannot have properties
  var primitive = formatPrimitive(ctx, value);
  if (primitive) {
    return primitive;
  }

  // Look up the keys of the object.
  var keys = Object.keys(value);
  var visibleKeys = arrayToHash(keys);

  if (ctx.showHidden) {
    keys = Object.getOwnPropertyNames(value);
  }

  // IE doesn't make error fields non-enumerable
  // http://msdn.microsoft.com/en-us/library/ie/dww52sbt(v=vs.94).aspx
  if (isError(value)
      && (keys.indexOf('message') >= 0 || keys.indexOf('description') >= 0)) {
    return formatError(value);
  }

  // Some type of object without properties can be shortcutted.
  if (keys.length === 0) {
    if (isFunction(value)) {
      var name = value.name ? ': ' + value.name : '';
      return ctx.stylize('[Function' + name + ']', 'special');
    }
    if (isRegExp(value)) {
      return ctx.stylize(RegExp.prototype.toString.call(value), 'regexp');
    }
    if (isDate(value)) {
      return ctx.stylize(Date.prototype.toString.call(value), 'date');
    }
    if (isError(value)) {
      return formatError(value);
    }
  }

  var base = '', array = false, braces = ['{', '}'];

  // Make Array say that they are Array
  if (isArray(value)) {
    array = true;
    braces = ['[', ']'];
  }

  // Make functions say that they are functions
  if (isFunction(value)) {
    var n = value.name ? ': ' + value.name : '';
    base = ' [Function' + n + ']';
  }

  // Make RegExps say that they are RegExps
  if (isRegExp(value)) {
    base = ' ' + RegExp.prototype.toString.call(value);
  }

  // Make dates with properties first say the date
  if (isDate(value)) {
    base = ' ' + Date.prototype.toUTCString.call(value);
  }

  // Make error with message first say the error
  if (isError(value)) {
    base = ' ' + formatError(value);
  }

  if (keys.length === 0 && (!array || value.length == 0)) {
    return braces[0] + base + braces[1];
  }

  if (recurseTimes < 0) {
    if (isRegExp(value)) {
      return ctx.stylize(RegExp.prototype.toString.call(value), 'regexp');
    } else {
      return ctx.stylize('[Object]', 'special');
    }
  }

  ctx.seen.push(value);

  var output;
  if (array) {
    output = formatArray(ctx, value, recurseTimes, visibleKeys, keys);
  } else {
    output = keys.map(function(key) {
      return formatProperty(ctx, value, recurseTimes, visibleKeys, key, array);
    });
  }

  ctx.seen.pop();

  return reduceToSingleString(output, base, braces);
}


function formatPrimitive(ctx, value) {
  if (isUndefined(value))
    return ctx.stylize('undefined', 'undefined');
  if (isString(value)) {
    var simple = '\'' + JSON.stringify(value).replace(/^"|"$/g, '')
                                             .replace(/'/g, "\\'")
                                             .replace(/\\"/g, '"') + '\'';
    return ctx.stylize(simple, 'string');
  }
  if (isNumber(value))
    return ctx.stylize('' + value, 'number');
  if (isBoolean(value))
    return ctx.stylize('' + value, 'boolean');
  // For some reason typeof null is "object", so special case here.
  if (isNull(value))
    return ctx.stylize('null', 'null');
}


function formatError(value) {
  return '[' + Error.prototype.toString.call(value) + ']';
}


function formatArray(ctx, value, recurseTimes, visibleKeys, keys) {
  var output = [];
  for (var i = 0, l = value.length; i < l; ++i) {
    if (hasOwnProperty(value, String(i))) {
      output.push(formatProperty(ctx, value, recurseTimes, visibleKeys,
          String(i), true));
    } else {
      output.push('');
    }
  }
  keys.forEach(function(key) {
    if (!key.match(/^\d+$/)) {
      output.push(formatProperty(ctx, value, recurseTimes, visibleKeys,
          key, true));
    }
  });
  return output;
}


function formatProperty(ctx, value, recurseTimes, visibleKeys, key, array) {
  var name, str, desc;
  desc = Object.getOwnPropertyDescriptor(value, key) || { value: value[key] };
  if (desc.get) {
    if (desc.set) {
      str = ctx.stylize('[Getter/Setter]', 'special');
    } else {
      str = ctx.stylize('[Getter]', 'special');
    }
  } else {
    if (desc.set) {
      str = ctx.stylize('[Setter]', 'special');
    }
  }
  if (!hasOwnProperty(visibleKeys, key)) {
    name = '[' + key + ']';
  }
  if (!str) {
    if (ctx.seen.indexOf(desc.value) < 0) {
      if (isNull(recurseTimes)) {
        str = formatValue(ctx, desc.value, null);
      } else {
        str = formatValue(ctx, desc.value, recurseTimes - 1);
      }
      if (str.indexOf('\n') > -1) {
        if (array) {
          str = str.split('\n').map(function(line) {
            return '  ' + line;
          }).join('\n').substr(2);
        } else {
          str = '\n' + str.split('\n').map(function(line) {
            return '   ' + line;
          }).join('\n');
        }
      }
    } else {
      str = ctx.stylize('[Circular]', 'special');
    }
  }
  if (isUndefined(name)) {
    if (array && key.match(/^\d+$/)) {
      return str;
    }
    name = JSON.stringify('' + key);
    if (name.match(/^"([a-zA-Z_][a-zA-Z_0-9]*)"$/)) {
      name = name.substr(1, name.length - 2);
      name = ctx.stylize(name, 'name');
    } else {
      name = name.replace(/'/g, "\\'")
                 .replace(/\\"/g, '"')
                 .replace(/(^"|"$)/g, "'");
      name = ctx.stylize(name, 'string');
    }
  }

  return name + ': ' + str;
}


function reduceToSingleString(output, base, braces) {
  var numLinesEst = 0;
  var length = output.reduce(function(prev, cur) {
    numLinesEst++;
    if (cur.indexOf('\n') >= 0) numLinesEst++;
    return prev + cur.replace(/\u001b\[\d\d?m/g, '').length + 1;
  }, 0);

  if (length > 60) {
    return braces[0] +
           (base === '' ? '' : base + '\n ') +
           ' ' +
           output.join(',\n  ') +
           ' ' +
           braces[1];
  }

  return braces[0] + base + ' ' + output.join(', ') + ' ' + braces[1];
}


// NOTE: These type checking functions intentionally don't use `instanceof`
// because it is fragile and can be easily faked with `Object.create()`.
function isArray(ar) {
  return Array.isArray(ar);
}
exports.isArray = isArray;

function isBoolean(arg) {
  return typeof arg === 'boolean';
}
exports.isBoolean = isBoolean;

function isNull(arg) {
  return arg === null;
}
exports.isNull = isNull;

function isNullOrUndefined(arg) {
  return arg == null;
}
exports.isNullOrUndefined = isNullOrUndefined;

function isNumber(arg) {
  return typeof arg === 'number';
}
exports.isNumber = isNumber;

function isString(arg) {
  return typeof arg === 'string';
}
exports.isString = isString;

function isSymbol(arg) {
  return typeof arg === 'symbol';
}
exports.isSymbol = isSymbol;

function isUndefined(arg) {
  return arg === void 0;
}
exports.isUndefined = isUndefined;

function isRegExp(re) {
  return isObject(re) && objectToString(re) === '[object RegExp]';
}
exports.isRegExp = isRegExp;

function isObject(arg) {
  return typeof arg === 'object' && arg !== null;
}
exports.isObject = isObject;

function isDate(d) {
  return isObject(d) && objectToString(d) === '[object Date]';
}
exports.isDate = isDate;

function isError(e) {
  return isObject(e) &&
      (objectToString(e) === '[object Error]' || e instanceof Error);
}
exports.isError = isError;

function isFunction(arg) {
  return typeof arg === 'function';
}
exports.isFunction = isFunction;

function isPrimitive(arg) {
  return arg === null ||
         typeof arg === 'boolean' ||
         typeof arg === 'number' ||
         typeof arg === 'string' ||
         typeof arg === 'symbol' ||  // ES6 symbol
         typeof arg === 'undefined';
}
exports.isPrimitive = isPrimitive;

exports.isBuffer = __webpack_require__(70);

function objectToString(o) {
  return Object.prototype.toString.call(o);
}


function pad(n) {
  return n < 10 ? '0' + n.toString(10) : n.toString(10);
}


var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep',
              'Oct', 'Nov', 'Dec'];

// 26 Feb 16:19:34
function timestamp() {
  var d = new Date();
  var time = [pad(d.getHours()),
              pad(d.getMinutes()),
              pad(d.getSeconds())].join(':');
  return [d.getDate(), months[d.getMonth()], time].join(' ');
}


// log is just a thin wrapper to console.log that prepends a timestamp
exports.log = function() {
  console.log('%s - %s', timestamp(), exports.format.apply(exports, arguments));
};


/**
 * Inherit the prototype methods from one constructor into another.
 *
 * The Function.prototype.inherits from lang.js rewritten as a standalone
 * function (not on Function.prototype). NOTE: If this file is to be loaded
 * during bootstrapping this function needs to be rewritten using some native
 * functions as prototype setup using normal JavaScript does not work as
 * expected during bootstrapping (see mirror.js in r114903).
 *
 * @param {function} ctor Constructor function which needs to inherit the
 *     prototype.
 * @param {function} superCtor Constructor function to inherit prototype from.
 */
exports.inherits = __webpack_require__(71);

exports._extend = function(origin, add) {
  // Don't do anything if add isn't an object
  if (!add || !isObject(add)) return origin;

  var keys = Object.keys(add);
  var i = keys.length;
  while (i--) {
    origin[keys[i]] = add[keys[i]];
  }
  return origin;
};

function hasOwnProperty(obj, prop) {
  return Object.prototype.hasOwnProperty.call(obj, prop);
}

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(20), __webpack_require__(69), __webpack_require__(6)))

/***/ }),
/* 56 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(console) {/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "c", function() { return SITE_CONFIG_LOADED; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return BASKETS_LOADED; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "b", function() { return QUICK_SEARCH_LOADED; });
/* harmony export (immutable) */ __webpack_exports__["f"] = loadSiteConfig;
/* harmony export (immutable) */ __webpack_exports__["d"] = loadBasketCounts;
/* harmony export (immutable) */ __webpack_exports__["e"] = loadQuickSearches;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils__ = __webpack_require__(74);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils__);
/**
 * Created by dfalke on 8/22/16.
 */



var SITE_CONFIG_LOADED = 'eupathdb/site-config-loaded';
var BASKETS_LOADED = 'eupathdb/basket';
var QUICK_SEARCH_LOADED = 'eupathdb/quick-search-loaded';

function loadSiteConfig(siteConfig) {
  return Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils__["broadcast"])({
    type: SITE_CONFIG_LOADED,
    payload: { siteConfig: siteConfig }
  });
}

function loadBasketCounts() {
  return function run(dispatch, _ref) {
    var wdkService = _ref.wdkService;

    wdkService.getCurrentUser().then(function (user) {
      if (user.isGuest) return;
      wdkService.getBasketCounts().then(function (basketCounts) {
        dispatch(Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils__["broadcast"])({
          type: BASKETS_LOADED,
          payload: { basketCounts: basketCounts }
        }));
      }).catch(function (error) {
        if (error.status !== 403) {
          console.error('Unexpected error while attempting to retrieve basket counts.', error);
        }
      });
    });
  };
}

/**
 * Load data for quick search
 * @param {Array<object>} questions An array of quick search spec objects.
 *    A spec object has two properties: `name`: the name of the questions,
 *    and `searchParam`: the name of the parameter to use for text box.
 * @return {run}
 */
function loadQuickSearches(questions) {
  return function run(dispatch, _ref2) {
    var wdkService = _ref2.wdkService;

    var requests = questions.map(function (reference) {
      return wdkService.getQuestionAndParameters(reference.name);
    });
    return Promise.all(requests).then(function (questions) {
      return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["keyBy"])(questions, 'name');
    }, function (error) {
      return error;
    }).then(function (questions) {
      return dispatch(Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_StaticDataUtils__["broadcast"])({
        type: QUICK_SEARCH_LOADED,
        payload: { questions: questions }
      }));
    });
  };
}
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 57 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(console) {/* harmony export (immutable) */ __webpack_exports__["a"] = selectReporterComponent;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__components_reporters_TabularReporterForm__ = __webpack_require__(22);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__components_reporters_TextReporterForm__ = __webpack_require__(23);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__components_reporters_XmlReporterForm__ = __webpack_require__(24);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__components_reporters_JsonReporterForm__ = __webpack_require__(25);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__components_reporters_Gff3ReporterForm__ = __webpack_require__(26);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__components_reporters_FastaGeneReporterForm__ = __webpack_require__(27);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__components_reporters_FastaGenomicSequenceReporterForm__ = __webpack_require__(28);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__components_reporters_FastaOrfReporterForm__ = __webpack_require__(29);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__components_reporters_FastaOrthoSequenceReporterForm__ = __webpack_require__(30);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10__components_reporters_TableReporterForm__ = __webpack_require__(12);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11__components_reporters_TranscriptTableReporterForm__ = __webpack_require__(31);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__components_reporters_TranscriptAttributesReporterForm__ = __webpack_require__(32);


// load individual reporter forms













var EmptyReporter = function EmptyReporter(props) {
  return React.createElement('noscript', null);
};

EmptyReporter.getInitialState = function () {
  return { formState: null, formUiState: null };
};

function selectReporterComponent(reporterName, recordClassName) {
  switch (reporterName) {
    case 'attributesTabular':
      switch (recordClassName) {
        case 'TranscriptRecordClasses.TranscriptRecordClass':
          return __WEBPACK_IMPORTED_MODULE_12__components_reporters_TranscriptAttributesReporterForm__["default"];
        default:
          return __WEBPACK_IMPORTED_MODULE_1__components_reporters_TabularReporterForm__["default"];
      }
    case 'tableTabular':
      switch (recordClassName) {
        case 'TranscriptRecordClasses.TranscriptRecordClass':
          return __WEBPACK_IMPORTED_MODULE_11__components_reporters_TranscriptTableReporterForm__["default"];
        default:
          return __WEBPACK_IMPORTED_MODULE_10__components_reporters_TableReporterForm__["default"];
      }
    case 'tabular':
      return __WEBPACK_IMPORTED_MODULE_1__components_reporters_TabularReporterForm__["default"];
    case 'srt':
      switch (recordClassName) {
        // both gene and transcript use the same reporter
        case 'GeneRecordClasses.GeneRecordClass':
        case 'TranscriptRecordClasses.TranscriptRecordClass':
          return __WEBPACK_IMPORTED_MODULE_6__components_reporters_FastaGeneReporterForm__["default"];
        case 'SequenceRecordClasses.SequenceRecordClass':
          return __WEBPACK_IMPORTED_MODULE_7__components_reporters_FastaGenomicSequenceReporterForm__["default"];
        case 'OrfRecordClasses.OrfRecordClass':
          return __WEBPACK_IMPORTED_MODULE_8__components_reporters_FastaOrfReporterForm__["default"];
        default:
          console.error("Unsupported FASTA recordClass: " + recordClassName);
          return EmptyReporter;
      }
    case 'fasta':
      return __WEBPACK_IMPORTED_MODULE_9__components_reporters_FastaOrthoSequenceReporterForm__["default"];
    case 'gff3':
      return __WEBPACK_IMPORTED_MODULE_5__components_reporters_Gff3ReporterForm__["default"];
    case 'fullRecord':
      return __WEBPACK_IMPORTED_MODULE_2__components_reporters_TextReporterForm__["default"];
    case 'xml':
      return __WEBPACK_IMPORTED_MODULE_3__components_reporters_XmlReporterForm__["default"];
    case 'json':
      return __WEBPACK_IMPORTED_MODULE_4__components_reporters_JsonReporterForm__["default"];
    // uncomment if adding service json reporter to model
    //case 'wdk-service-json':
    //  return Components.WdkServiceJsonReporterForm;
    default:
      return EmptyReporter;
  }
}
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 58 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = formatReleaseDate;
var MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

/**
 * format release date string
 */
function formatReleaseDate(releaseDateString, format) {
  var date = new Date(releaseDateString);
  return (typeof format === 'string' ? format : 'd m y').replace('d', date.getDate()).replace('m', MONTHS[date.getMonth()]).replace('y', date.getFullYear());
}

/***/ }),
/* 59 */
/***/ (function(module, exports) {

module.exports = Wdk.FilterServiceUtils;

/***/ }),
/* 60 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* WEBPACK VAR INJECTION */(function(console) {/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__util_http__ = __webpack_require__(91);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }





/**
 * Renders an Dataset graph with the provided rowData.
 * rowData comes from an ExpressionTable record table.
 *
 * rowData will include the available gene ids (graph_ids), but the available
 * graphs for the dataset (visible_parts) has to be fetched from dataPlotter.pl.
 * This means that when we get new rowData, we first have to make a request for
 * the available parts, and then we can update the state of the Component. This
 * flow will ensure that we have a consistent state when rendering.
 */

var DatasetGraph = function (_PureComponent) {
  _inherits(DatasetGraph, _PureComponent);

  function DatasetGraph() {
    var _ref;

    _classCallCheck(this, DatasetGraph);

    for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
      args[_key] = arguments[_key];
    }

    var _this = _possibleConstructorReturn(this, (_ref = DatasetGraph.__proto__ || Object.getPrototypeOf(DatasetGraph)).call.apply(_ref, [this].concat(args)));

    var graphIds = _this.props.rowData.graph_ids.split(/\s*,\s*/);
    _this.state = {
      loading: true,
      imgError: false,
      parts: null,
      visibleParts: null,
      descriptionCollapsed: true,
      dataTableCollapsed: true,
      coverageCollapsed: true,
      showLogScale: _this.props.rowData.assay_type == 'RNA-seq' ? false : true,
      graphId: graphIds[0],
      contXAxis: 'none',
      facet: 'none'
    };

    _this.handleDescriptionCollapseChange = function (descriptionCollapsed) {
      _this.setState({ descriptionCollapsed: descriptionCollapsed });
    };
    _this.handleDataTableCollapseChange = function (dataTableCollapsed) {
      _this.setState({ dataTableCollapsed: dataTableCollapsed });
    };
    _this.handleCoverageCollapseChange = function (coverageCollapsed) {
      _this.setState({ coverageCollapsed: coverageCollapsed });
    };
    return _this;
  }

  _createClass(DatasetGraph, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.getGraphParts(this.props);
    }
  }, {
    key: 'componentWillUnmount',
    value: function componentWillUnmount() {
      this.request.abort();
      console.trace('DatasetGraph is unmounting');
    }
  }, {
    key: 'componentWillReceiveProps',
    value: function componentWillReceiveProps(nextProps) {
      if (this.props.rowData !== nextProps.rowData) {
        this.request.abort();
        this.getGraphParts(nextProps);
      }
    }
  }, {
    key: 'makeBaseUrl',
    value: function makeBaseUrl(_ref2) {
      var rowData = _ref2.rowData;

      var graphIds = rowData.graph_ids.split(/\s*,\s*/);
      var graphId = this.state.graphId || graphIds[0];
      return '/cgi-bin/dataPlotter.pl?' + 'type=' + rowData.module + '&' + 'project_id=' + rowData.project_id + '&' + 'datasetId=' + rowData.dataset_id + '&' + 'template=' + (rowData.is_graph_custom === 'false' ? 1 : 0) + '&' + 'id=' + graphId;
    }
  }, {
    key: 'makeDatasetUrl',
    value: function makeDatasetUrl(_ref3) {
      var rowData = _ref3.rowData;

      return '../dataset/' + rowData.dataset_id;
    }
  }, {
    key: 'makeTutorialUrl',
    value: function makeTutorialUrl(_ref4) {
      var rowData = _ref4.rowData;

      return '../../../../documents/FromCoverageNonuniqueReads.pdf';
    }
  }, {
    key: 'getGraphParts',
    value: function getGraphParts(props) {
      var _this2 = this;

      var baseUrl = this.makeBaseUrl(props);
      this.setState({ loading: true });
      this.request = Object(__WEBPACK_IMPORTED_MODULE_0__util_http__["a" /* httpGet */])(baseUrl + '&declareParts=1');
      this.request.promise().then(function (partsString) {
        var parts = partsString.split(/\s*,\s*/);
        var visibleParts = parts.slice(0, 1);
        _this2.setState({ parts: parts, visibleParts: visibleParts, loading: false });
      });
    }
  }, {
    key: 'setGraphId',
    value: function setGraphId(graphId) {
      if (this.state.graphId !== graphId) {
        this.setState({ graphId: graphId });
        this.getGraphParts(this.props);
      }
    }
  }, {
    key: 'setFacet',
    value: function setFacet(myfacet) {
      if (this.state.facet !== myfacet) {
        this.setState({ loading: true,
          facet: myfacet });
      }
    }
  }, {
    key: 'setContXAxis',
    value: function setContXAxis(myXAxis) {
      if (this.state.contXAxis !== myXAxis) {
        this.setState({ loading: true,
          contXAxis: myXAxis });
      }
    }
  }, {
    key: 'renderLoading',
    value: function renderLoading() {
      if (this.state.loading) {
        return React.createElement(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["Loading"], { radius: 4, className: 'eupathdb-DatasetGraphLoading' });
      }
    }
  }, {
    key: 'renderImgError',
    value: function renderImgError() {
      if (this.state.imgError) {
        return React.createElement(
          'div',
          { className: 'eupathdb-ExpressGraphErrorMessage' },
          'The requested graph could not be loaded.'
        );
      }
    }
  }, {
    key: 'render',
    value: function render() {
      var _this3 = this;

      var _props = this.props,
          dataTable = _props.dataTable,
          facetMetadataTable = _props.facetMetadataTable,
          contXAxisMetadataTable = _props.contXAxisMetadataTable,
          _props$rowData = _props.rowData,
          source_id = _props$rowData.source_id,
          assay_type = _props$rowData.assay_type,
          module = _props$rowData.module,
          paralog_number = _props$rowData.paralog_number,
          graph_ids = _props$rowData.graph_ids,
          dataset_id = _props$rowData.dataset_id,
          dataset_name = _props$rowData.dataset_name,
          description = _props$rowData.description,
          x_axis = _props$rowData.x_axis,
          y_axis = _props$rowData.y_axis;


      var graphIds = graph_ids.split(/\s*,\s*/);
      var _state = this.state,
          parts = _state.parts,
          visibleParts = _state.visibleParts,
          showLogScale = _state.showLogScale,
          graphId = _state.graphId,
          facet = _state.facet,
          contXAxis = _state.contXAxis;


      var baseUrl = this.makeBaseUrl(this.props);
      var baseUrlWithState = baseUrl + '&id=' + graphId + '&vp=' + visibleParts + '&wl=' + (showLogScale ? '1' : '0');
      var baseUrlWithMetadata = baseUrlWithState + '&facet=' + facet + '&contXAxis=' + contXAxis;
      var imgUrl = baseUrlWithMetadata + '&fmt=svg';
      var pngUrl = baseUrlWithMetadata + '&fmt=png';
      var covImgUrl = dataTable && dataTable.record.attributes.CoverageGbrowseUrl + '%1E' + dataset_name + 'CoverageUnlogged';
      var dataset_link = this.makeDatasetUrl(this.props);
      var tutorial_link = this.makeTutorialUrl(this.props);

      return React.createElement(
        'div',
        { className: 'eupathdb-DatasetGraphContainer2' },
        React.createElement(
          'div',
          { className: 'eupathdb-DatasetGraphContainer' },
          this.renderLoading(),
          React.createElement(
            'div',
            { className: 'eupathdb-DatasetGraph' },
            visibleParts && React.createElement('object', {
              style: { minHeight: 220 },
              data: imgUrl,
              type: 'image/svg+xml',
              onLoad: function onLoad() {
                _this3.setState({ loading: false });
              },
              onError: function onError() {
                return _this3.setState({ loading: false, imgError: true });
              } }),
            this.renderImgError(),
            React.createElement(
              'h4',
              { hidden: this.props.contXAxisMetadataTable ? false : true },
              'Choose metadata category for X-axis:'
            ),
            React.createElement(
              'select',
              { value: this.state.contXAxis, hidden: this.props.contXAxisMetadataTable ? false : true, onChange: function onChange(event) {
                  return _this3.setContXAxis(event.target.value);
                } },
              React.createElement(
                'option',
                { value: 'none' },
                'None'
              ),
              this.props.contXAxisMetadataTable && contXAxisMetadataTable.value.filter(function (dat) {
                return dat.dataset_id == dataset_id;
              }).map(function (xAxisRow) {
                return React.createElement(
                  'option',
                  { value: xAxisRow.property_id },
                  xAxisRow.property
                );
              })
            ),
            React.createElement(
              'h4',
              { hidden: this.props.facetMetadataTable ? false : true },
              'Choose metadata category to facet graph on:'
            ),
            React.createElement(
              'select',
              { value: this.state.facet, hidden: this.props.facetMetadataTable ? false : true, onChange: function onChange(event) {
                  return _this3.setFacet(event.target.value);
                } },
              React.createElement(
                'option',
                { value: 'none' },
                'None'
              ),
              this.props.facetMetadataTable && facetMetadataTable.value.filter(function (dat) {
                return dat.dataset_id == dataset_id;
              }).map(function (facetRow) {
                return React.createElement(
                  'option',
                  { value: facetRow.property_id },
                  facetRow.property
                );
              })
            ),
            React.createElement(
              'h4',
              null,
              React.createElement(
                'a',
                { href: dataset_link },
                'Full Dataset Description'
              )
            ),
            graphId !== source_id ? React.createElement(
              'div',
              null,
              React.createElement(
                'b',
                null,
                React.createElement(
                  'font',
                  { color: 'firebrick' },
                  'WARNING'
                )
              ),
              ': This Gene (',
              source_id,
              ' ) does not have data for this experiment. Instead, we are showing data for this same gene(s) from the reference strain for this species. This may or may NOT accurately represent the gene you are interested in. '
            ) : null,
            assay_type == 'RNA-seq' && paralog_number > 0 && module !== 'SpliceSites' && covImgUrl ? React.createElement(
              'div',
              null,
              React.createElement(
                'b',
                null,
                React.createElement(
                  'font',
                  { color: 'firebrick' },
                  'Warning: This gene has ',
                  Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(paralog_number, {}, 'b'),
                  ' paralogs!'
                )
              ),
              React.createElement('br', null),
              'Please consider non-unique aligned reads in the expression graph and coverage plots in the genome browser (',
              React.createElement(
                'a',
                { href: tutorial_link },
                React.createElement(
                  'b',
                  null,
                  'tutorial'
                )
              ),
              ').'
            ) : null,
            assay_type == 'RNA-seq' && module !== 'SpliceSites' && covImgUrl ? React.createElement(
              __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["CollapsibleSection"],
              {
                id: dataset_name + "Coverage",
                className: 'eupathdb-GbrowseContext',
                headerContent: 'Coverage',
                isCollapsed: this.state.coverageCollapsed,
                onCollapsedChange: this.handleCoverageCollapseChange },
              React.createElement(
                'div',
                null,
                'Non-unique mapping may be examined in the genome browser (',
                React.createElement(
                  'a',
                  { href: tutorial_link },
                  React.createElement(
                    'b',
                    null,
                    'tutorial'
                  )
                ),
                ')',
                React.createElement('br', null),
                React.createElement('br', null),
                React.createElement(
                  'a',
                  { href: covImgUrl.replace('/gbrowse_img/', '/gbrowse/') },
                  'View in genome browser'
                )
              ),
              React.createElement('img', { width: '450', src: covImgUrl })
            ) : null
          ),
          React.createElement(
            'div',
            { className: 'eupathdb-DatasetGraphDetails' },
            this.props.dataTable && React.createElement(
              __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["CollapsibleSection"],
              {
                className: "eupathdb-" + this.props.dataTable.table.name + "Container",
                headerContent: 'Data table',
                headerComponent: 'h4',
                isCollapsed: this.state.dataTableCollapsed,
                onCollapsedChange: this.handleDataTableCollapseChange },
              React.createElement(dataTable.DefaultComponent, {
                record: dataTable.record,
                recordClass: dataTable.recordClass,
                table: dataTable.table,
                value: dataTable.value.filter(function (dat) {
                  return dat.dataset_id == dataset_id;
                })
              })
            ),
            React.createElement(
              __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["CollapsibleSection"],
              {
                className: "eupathdb-DatasetGraphDescription",
                headerContent: 'Description',
                headerComponent: 'h4',
                isCollapsed: this.state.descriptionCollapsed,
                onCollapsedChange: this.handleDescriptionCollapseChange },
              Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(description, {}, 'div')
            ),
            React.createElement(
              'h4',
              null,
              'X-axis'
            ),
            Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(x_axis, {}, 'div'),
            React.createElement(
              'h4',
              null,
              'Y-axis'
            ),
            Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["safeHtml"])(y_axis, {}, 'div'),
            React.createElement(
              'h4',
              null,
              'Choose gene for which to display graph'
            ),
            graphIds.map(function (graphId) {
              return React.createElement(
                'label',
                { key: graphId },
                React.createElement('input', {
                  type: 'radio',
                  checked: graphId === _this3.state.graphId,
                  onChange: function onChange() {
                    return _this3.setGraphId(graphId);
                  }
                }),
                ' ',
                graphId,
                ' '
              );
            }),
            React.createElement(
              'h4',
              null,
              'Choose graph(s) to display'
            ),
            parts && visibleParts && parts.map(function (part) {
              return React.createElement(
                'label',
                { key: part },
                React.createElement('input', {
                  type: 'checkbox',
                  checked: visibleParts.indexOf(part) > -1,
                  onChange: function onChange(e) {
                    return _this3.setState({
                      loading: true,
                      visibleParts: e.target.checked ? visibleParts.concat(part) : visibleParts.filter(function (p) {
                        return p !== part;
                      })
                    });
                  }
                }),
                ' ',
                part,
                ' '
              );
            }),
            React.createElement(
              'h4',
              null,
              'Graph options'
            ),
            React.createElement(
              'div',
              null,
              React.createElement(
                'label',
                null,
                React.createElement('input', {
                  type: 'checkbox',
                  checked: showLogScale,
                  onChange: function onChange(e) {
                    return _this3.setState({ loading: true, showLogScale: e.target.checked });
                  }
                }),
                ' Show log Scale (not applicable for log(ratio) graphs, percentile graphs or data tables)'
              )
            )
          )
        )
      );
    }
  }]);

  return DatasetGraph;
}(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["PureComponent"]);

/* harmony default export */ __webpack_exports__["default"] = (DatasetGraph);
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 61 */
/***/ (function(module, exports) {

module.exports = jQuery;

/***/ }),
/* 62 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__ = __webpack_require__(16);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }




var FooterController = function (_WdkViewController) {
  _inherits(FooterController, _WdkViewController);

  function FooterController() {
    _classCallCheck(this, FooterController);

    return _possibleConstructorReturn(this, (FooterController.__proto__ || Object.getPrototypeOf(FooterController)).apply(this, arguments));
  }

  _createClass(FooterController, [{
    key: 'renderView',
    value: function renderView() {
      return React.createElement(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["Footer"], null);
    }
  }]);

  return FooterController;
}(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__["WdkViewController"]);

/* harmony default export */ __webpack_exports__["default"] = (FooterController);

/***/ }),
/* 63 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__ = __webpack_require__(16);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }




var HeaderController = function (_WdkViewController) {
  _inherits(HeaderController, _WdkViewController);

  function HeaderController() {
    _classCallCheck(this, HeaderController);

    return _possibleConstructorReturn(this, (HeaderController.__proto__ || Object.getPrototypeOf(HeaderController)).apply(this, arguments));
  }

  _createClass(HeaderController, [{
    key: 'renderView',
    value: function renderView() {
      return React.createElement(__WEBPACK_IMPORTED_MODULE_1_wdk_client_Components__["Header"], null);
    }
  }]);

  return HeaderController;
}(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Controllers__["WdkViewController"]);

/* harmony default export */ __webpack_exports__["default"] = (HeaderController);

/***/ }),
/* 64 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* WEBPACK VAR INJECTION */(function(console) {/* harmony export (immutable) */ __webpack_exports__["sortDistribution"] = sortDistribution;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_jquery__ = __webpack_require__(61);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_jquery___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_jquery__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_natural_sort__ = __webpack_require__(93);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_natural_sort___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_natural_sort__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_react_dom__ = __webpack_require__(19);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_react_dom___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_5_react_dom__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_6_wdk_client_Components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8_wdk_client_Controllers__ = __webpack_require__(16);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8_wdk_client_Controllers___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_8_wdk_client_Controllers__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__ = __webpack_require__(13);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_wdk_client_PromiseUtils__ = __webpack_require__(94);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_10_wdk_client_PromiseUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_10_wdk_client_PromiseUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11_wdk_client_Stores__ = __webpack_require__(95);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_11_wdk_client_Stores___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_11_wdk_client_Stores__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_12__components_QuestionWizard__ = __webpack_require__(15);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__ = __webpack_require__(43);
var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _toArray(arr) { return Array.isArray(arr) ? arr : Array.from(arr); }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/*global wdk*/

















var natSortComparator = __WEBPACK_IMPORTED_MODULE_2_natural_sort___default()();

//  type State = {
//    question: Question;
//    activeGroup: Group;
//    groupUIState: Record<string, {
//      valid?: boolean;
//      loading?: boolean;
//      accumulatedTotal?: boolean;
//    }>;
//    paramUIState: Record<string, any>;
//    paramValues: Record<string, string>;
//  }

// FIXME Don't update param dependencies if value is empty

/**
 * Controller for question wizard
 *
 * FIXME Move state management into a Store. As-is, there are potential race
 * conditions due to `setState()` being async.
 */

var QuestionWizardController = function (_AbstractViewControll) {
  _inherits(QuestionWizardController, _AbstractViewControll);

  function QuestionWizardController(props) {
    _classCallCheck(this, QuestionWizardController);

    var _this = _possibleConstructorReturn(this, (QuestionWizardController.__proto__ || Object.getPrototypeOf(QuestionWizardController)).call(this, props));

    _this.state = {};
    _this.parameterMap = null;
    _this.eventHandlers = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["mapValues"])(_this.getEventHandlers(), function (handler) {
      return handler.bind(_this);
    });

    _this._getAnswerCount = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["memoize"])(_this._getAnswerCount, function () {
      for (var _len = arguments.length, args = Array(_len), _key = 0; _key < _len; _key++) {
        args[_key] = arguments[_key];
      }

      return JSON.stringify(args);
    });
    _this._getFilterCounts = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["memoize"])(_this._getFilterCounts, function () {
      for (var _len2 = arguments.length, args = Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
        args[_key2] = arguments[_key2];
      }

      return JSON.stringify(args);
    });
    _this._updateGroupCounts = Object(__WEBPACK_IMPORTED_MODULE_10_wdk_client_PromiseUtils__["synchronized"])(_this._updateGroupCounts);
    _this._commitParamValueChange = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["debounce"])(Object(__WEBPACK_IMPORTED_MODULE_10_wdk_client_PromiseUtils__["synchronized"])(_this._commitParamValueChange), 1000);
    return _this;
  }

  _createClass(QuestionWizardController, [{
    key: 'getStoreClass',
    value: function getStoreClass() {
      return __WEBPACK_IMPORTED_MODULE_11_wdk_client_Stores__["WdkStore"];
    }
  }, {
    key: 'getStateFromStore',
    value: function getStateFromStore() {
      return {};
    }
  }, {
    key: 'getEventHandlers',
    value: function getEventHandlers() {
      return Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["pick"])(this, ['setActiveGroup', 'setActiveOntologyTerm', 'setOntologyTermSort', 'setOntologyTermSearch', 'setParamState', 'setParamValue', 'updateInvalidGroupCounts', 'setFilterPopupVisiblity', 'setFilterPopupPinned', 'resetParamValues']);
    }
  }, {
    key: 'loadQuestion',
    value: function loadQuestion(props) {
      var _this2 = this;

      var questionName = props.questionName,
          wdkService = props.wdkService,
          isRevise = props.isRevise,
          paramValues = props.paramValues;


      var question$ = isRevise ? wdkService.getQuestionGivenParameters(questionName, paramValues) : wdkService.getQuestionAndParameters(questionName);

      var recordClass$ = question$.then(function (question) {
        return wdkService.findRecordClass(function (rc) {
          return rc.name === question.recordClassName;
        });
      });

      Promise.all([question$, recordClass$]).then(function (_ref) {
        var _ref2 = _slicedToArray(_ref, 2),
            question = _ref2[0],
            recordClass = _ref2[1];

        _this2.setState(Object(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["a" /* createInitialState */])(question, recordClass, paramValues), function () {
          document.title = 'Search for ' + recordClass.displayName + ' by ' + question.displayName;
          // store <string, Parameter>Map for quick lookup
          _this2.parameterMap = new Map(question.parameters.map(function (p) {
            return [p.name, p];
          }));

          var defaultParamValues = Object(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["b" /* getDefaultParamValues */])(_this2.state);
          var lastConfiguredGroup = __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(question.groups).filter(function (group) {
            return group.parameters.some(function (paramName) {
              return paramValues[paramName] !== defaultParamValues[paramName];
            });
          }).last();
          var configuredGroups = lastConfiguredGroup == null ? [] : __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(question.groups).takeWhile(function (group) {
            return group !== lastConfiguredGroup;
          }).concat(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].of(lastConfiguredGroup));

          _this2._updateGroupCounts(configuredGroups);
          _this2._getAnswerCount({
            questionName: question.name,
            parameters: defaultParamValues
          }).then(function (initialCount) {
            _this2.setState({ initialCount: initialCount });
          });

          _this2.setActiveGroup(question.groups[0]);
        });
      }, function (error) {
        _this2.setState({ error: error });
      });
    }

    // Top level action creator methods
    // --------------------------------


    /**
     * Update selected group and its count.
     */

  }, {
    key: 'setActiveGroup',
    value: function setActiveGroup(activeGroup) {
      this.setState({ activeGroup: activeGroup });

      if (activeGroup == null) return;

      // FIXME Updating group counts and filter param counts needs to wait for
      // any dependent param updates to finish first.

      // Update counts for active group and upstream groups
      var groupsToUpdate = __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(this.state.question.groups).takeWhile(function (group) {
        return group !== activeGroup;
      }).concat(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].of(activeGroup));

      this._updateGroupCounts(groupsToUpdate);

      // TODO Perform sideeffects elsewhere
      // BEGIN_SIDE_EFFECTS
      this._initializeActiveGroupParams(activeGroup);
      // END_SIDE_EFFECTS
    }
  }, {
    key: 'setParamState',
    value: function setParamState(param, state) {
      this.setState(updateState(['paramUIState', param.name], state));
    }

    /**
     * Set filter popup visiblity
     */

  }, {
    key: 'setFilterPopupVisiblity',
    value: function setFilterPopupVisiblity(show) {
      this.setState(function (state) {
        return Object(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["h" /* setFilterPopupVisiblity */])(state, show);
      });
    }

    /**
     * Set filter popup stickyness
     */

  }, {
    key: 'setFilterPopupPinned',
    value: function setFilterPopupPinned(pinned) {
      this.setState(function (state) {
        return Object(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["g" /* setFilterPopupPinned */])(state, pinned);
      });
    }

    /**
     * Set all params to default values, then update group counts and ontology term summaries
     */

  }, {
    key: 'resetParamValues',
    value: function resetParamValues() {
      var _this3 = this;

      // reset values
      this.setState(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["f" /* resetParamValues */], function () {
        _this3._updateGroupCounts(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(_this3.state.question.groups).filter(function (group) {
          return _this3.state.groupUIState[group.name].accumulatedTotal != null;
        }));
      });

      // clear ontology term summaries
      var paramUIState = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["mapValues"])(this.state.paramUIState, function (state) {
        return Object.assign({}, state, {
          ontologyTermSummaries: state.ontologyTermSummaries && {}
        });
      });

      this.setState({ paramUIState: paramUIState }, function () {
        __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(_this3.state.activeGroup.parameters).map(function (paramName) {
          return _this3.parameterMap.get(paramName);
        }).filter(function (param) {
          return param.type === 'FilterParamNew';
        }).forEach(function (param) {
          _this3.setActiveOntologyTerm(param, [], _this3.state.paramUIState[param.name].activeOntologyTerm);
        });
      });
    }

    /**
     * Force stale counts to be updated.
     */

  }, {
    key: 'updateInvalidGroupCounts',
    value: function updateInvalidGroupCounts() {
      var _this4 = this;

      this._updateGroupCounts(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(this.state.question.groups).filter(function (group) {
        return _this4.state.groupUIState[group.name].valid === false;
      }));
    }

    /**
     * Update paramUI state based on ontology term.
     */

  }, {
    key: 'setActiveOntologyTerm',
    value: function setActiveOntologyTerm(param, filters, ontologyTerm) {
      this.setState(updateState(['paramUIState', param.name, 'activeOntologyTerm'], ontologyTerm));
      if (this._getParamUIState(this.state, param.name).ontologyTermSummaries[ontologyTerm] == null) {
        this._updateOntologyTermSummary(param.name, ontologyTerm, filters);
      }
    }
  }, {
    key: 'setOntologyTermSort',
    value: function setOntologyTermSort(param, term, sort) {
      var uiState = this.state.paramUIState[param.name];
      var ontologyTermSummaries = uiState.ontologyTermSummaries,
          fieldStates = uiState.fieldStates,
          defaultMemberFieldState = uiState.defaultMemberFieldState;

      var _JSON$parse = JSON.parse(this.state.paramValues[param.name]),
          _JSON$parse$filters = _JSON$parse.filters,
          filters = _JSON$parse$filters === undefined ? [] : _JSON$parse$filters;

      var filter = filters.find(function (f) {
        return f.field === term;
      });
      var newState = Object.assign({}, uiState, {
        ontologyTermSummaries: Object.assign({}, ontologyTermSummaries, _defineProperty({}, term, Object.assign({}, ontologyTermSummaries[term], {
          valueCounts: sortDistribution(ontologyTermSummaries[term].valueCounts, sort, filter)
        }))),
        fieldStates: Object.assign({}, fieldStates, _defineProperty({}, term, Object.assign({}, fieldStates[term] || defaultMemberFieldState, {
          sort: sort
        })))
      });
      this.setParamState(param, newState);
    }
  }, {
    key: 'setOntologyTermSearch',
    value: function setOntologyTermSearch(param, term, searchTerm) {
      var uiState = this.state.paramUIState[param.name];
      var fieldStates = uiState.fieldStates,
          defaultMemberFieldState = uiState.defaultMemberFieldState;

      var newState = Object.assign({}, uiState, {
        fieldStates: Object.assign({}, fieldStates, _defineProperty({}, term, Object.assign({}, fieldStates[term] || defaultMemberFieldState, {
          searchTerm: searchTerm
        })))
      });
      this.setParamState(param, newState);
    }

    /**
     * Update parameter value, update dependent parameter vocabularies and
     * ontologies, and update counts.
     */

  }, {
    key: 'setParamValue',
    value: function setParamValue(param, paramValue) {
      var _this5 = this;

      var prevParamValue = this.state.paramValues[param.name];

      this.setState(updateState(['paramValues', param.name], paramValue), function () {
        return _this5._commitParamValueChange(param, paramValue, prevParamValue);
      });
      this.setState(updateState(['groupUIState', param.group, 'loading'], true));

      if (param.type === 'FilterParamNew') {
        // for each changed member updated member field, resort
        var paramState = this.state.paramUIState[param.name];

        var _JSON$parse2 = JSON.parse(paramValue),
            _JSON$parse2$filters = _JSON$parse2.filters,
            filters = _JSON$parse2$filters === undefined ? [] : _JSON$parse2$filters;

        var _JSON$parse3 = JSON.parse(this.state.paramValues[param.name]),
            _JSON$parse3$filters = _JSON$parse3.filters,
            prevFilters = _JSON$parse3$filters === undefined ? [] : _JSON$parse3$filters;

        var filtersByTerm = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["keyBy"])(filters, 'field');
        var prevFiltersByTerm = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["keyBy"])(prevFilters, 'field');
        var fieldMap = new Map(param.ontology.map(function (entry) {
          return [entry.term, entry];
        }));
        var ontologyTermSummaries = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["mapValues"])(paramState.ontologyTermSummaries, function (summary, term) {
          return fieldMap.get(term).isRange || filtersByTerm[term] === prevFiltersByTerm[term] ? summary : Object.assign({}, summary, {
            valueCounts: sortDistribution(summary.valueCounts, (paramState.fieldStates[term] || paramState.defaultMemberFieldState).sort, filtersByTerm[term])
          });
        });
        this.setParamState(param, Object.assign({}, paramState, { ontologyTermSummaries: ontologyTermSummaries }));
      }
    }
  }, {
    key: '_initializeActiveGroupParams',
    value: function _initializeActiveGroupParams(activeGroup) {
      var _this6 = this;

      activeGroup.parameters.forEach(function (paramName) {
        var param = _this6.state.question.parameters.find(function (param) {
          return param.name === paramName;
        });
        if (param == null) throw new Error("Could not find param `" + paramName + "`.");
        if (param.type === 'FilterParamNew') {
          var _getParamUIState2 = _this6._getParamUIState(_this6.state, paramName),
              activeOntologyTerm = _getParamUIState2.activeOntologyTerm,
              ontologyTermSummaries = _getParamUIState2.ontologyTermSummaries;

          var _JSON$parse4 = JSON.parse(_this6.state.paramValues[param.name]),
              filters = _JSON$parse4.filters;

          _this6._updateFilterParamCounts(param.name, filters);
          if (activeOntologyTerm && ontologyTermSummaries[activeOntologyTerm] == null) {
            _this6._updateOntologyTermSummary(param.name, activeOntologyTerm, filters);
          }
        }
      });
    }
  }, {
    key: '_commitParamValueChange',
    value: function _commitParamValueChange(param, paramValue, prevParamValue) {
      var _this7 = this;

      var groups = __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(this.state.question.groups);
      var currentGroup = groups.find(function (group) {
        return group.parameters.includes(param.name);
      });
      groups.dropWhile(function (group) {
        return group !== currentGroup;
      }).drop(1).takeWhile(function (group) {
        return _this7._groupHasCount(group);
      }).forEach(function (group) {
        _this7.setState(updateState(['groupUIState', group.name, 'valid'], false));
      });

      return Promise.all([this._handleParamValueChange(param, paramValue, prevParamValue), this._updateDependedParams(param, paramValue, this.state.paramValues).then(function (nextState) {
        _this7.setState(nextState, function () {
          _this7._updateGroupCounts(groups.takeWhile(function (group) {
            return group !== _this7.state.activeGroup;
          }).concat(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].of(_this7.state.activeGroup)));
          _this7._initializeActiveGroupParams(_this7.state.activeGroup);
        });
      })]);
    }
  }, {
    key: '_handleParamValueChange',
    value: function _handleParamValueChange(param, paramValue, prevParamValue) {
      if (param.type === 'FilterParamNew') {
        var _JSON$parse5 = JSON.parse(paramValue),
            _JSON$parse5$filters = _JSON$parse5.filters,
            filters = _JSON$parse5$filters === undefined ? [] : _JSON$parse5$filters;

        var _JSON$parse6 = JSON.parse(prevParamValue),
            _JSON$parse6$filters = _JSON$parse6.filters,
            oldFilters = _JSON$parse6$filters === undefined ? [] : _JSON$parse6$filters;

        var _getParamUIState3 = this._getParamUIState(this.state, param.name),
            activeOntologyTerm = _getParamUIState3.activeOntologyTerm,
            ontologyTermSummaries = _getParamUIState3.ontologyTermSummaries;

        // Get an array of fields whose associated filters have been modified.


        var modifiedFields = Object.entries(Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["groupBy"])(filters.concat(oldFilters), 'field')).filter(function (_ref3) {
          var _ref4 = _slicedToArray(_ref3, 2),
              filters = _ref4[1];

          return filters.length === 1 || !Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["isEqual"])(filters[0], filters[1]);
        }).map(function (_ref5) {
          var _ref6 = _slicedToArray(_ref5, 1),
              field = _ref6[0];

          return field;
        });

        var singleModifiedField = modifiedFields.length === 1 ? modifiedFields[0] : null;

        var shouldUpdateActiveOntologyTermSummary = singleModifiedField !== activeOntologyTerm;

        // Ontology term summaries we want to keep. We definitely want to keep the
        // active ontology summary to prevent an empty panel while it's loading.
        // Also, in the case that only a single filter has been modified, we don't
        // need to update the associated ontologyTermSummary.
        var newOntologyTermSummaries = Object.assign(_defineProperty({}, activeOntologyTerm, ontologyTermSummaries[activeOntologyTerm]), singleModifiedField && _defineProperty({}, singleModifiedField, ontologyTermSummaries[singleModifiedField]));

        this.setState(updateState(['paramUIState', param.name, 'ontologyTermSummaries'], newOntologyTermSummaries));

        return Promise.all([this._updateFilterParamCounts(param.name, filters),
        // This only needs to be called if the modified filter value is not for
        // the active ontology term.
        shouldUpdateActiveOntologyTermSummary && this._updateOntologyTermSummary(param.name, activeOntologyTerm, filters)]);
      }

      return Promise.resolve();
    }

    /**
     * Returns a new object with updated paramValues and paramUIState
     * @param {*} rootParam
     * @param {*} paramValue
     */

  }, {
    key: '_updateDependedParams',
    value: function _updateDependedParams(rootParam, paramValue, paramValues) {
      var _this8 = this;

      return this.props.wdkService.getQuestionParamValues(this.state.question.urlSegment, rootParam.name, paramValue, paramValues).then(
      // for each parameter returned, reset vocab/ontology and param value
      function (parameters) {
        return __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(parameters).uniqBy(function (p) {
          return p.name;
        }).flatMap(function (param) {
          switch (param.type) {
            case 'FilterParamNew':
              {
                // Return new state object with updates to param state and value
                var ontology = param.values == null ? param.ontology : param.ontology.map(function (entry) {
                  return param.values[entry.term] == null ? entry : Object.assign(entry, {
                    values: param.values[entry.term].join(' ')
                  });
                });
                return [updateState(['paramUIState', param.name, 'ontology'], ontology), updateState(['paramValues', param.name], param.defaultValue)];
              }
            case 'FlatVocabParam':
            case 'EnumParam':
              {
                return [updateState(['paramUIState', param.name, 'vocabulary'], param.vocabulary), updateState(['paramValues', param.name], param.defaultValue)];
              }
            default:
              {
                console.warn('Unable to handle unexpected param type `%o`.', param.type);
                return [__WEBPACK_IMPORTED_MODULE_1_lodash__["identity"]];
              }
          }
        }).reduce(Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["ary"])(__WEBPACK_IMPORTED_MODULE_1_lodash__["flow"], 2), __WEBPACK_IMPORTED_MODULE_1_lodash__["identity"]);
      }).then(function (updater) {
        return (
          // Then, clear ontologyTermSummaries for dependent FilterParamNew params
          __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(_this8._getDeepParameterDependencies(rootParam)).filter(function (parameter) {
            return parameter.type === 'FilterParamNew';
          }).map(function (parameter) {
            return updateState(['paramUIState', parameter.name, 'ontologyTermSummaries'], {});
          }).reduce(Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["ary"])(__WEBPACK_IMPORTED_MODULE_1_lodash__["flow"], 2), updater)
        );
      });
    }
  }, {
    key: '_getDeepParameterDependencies',
    value: function _getDeepParameterDependencies(rootParameter) {
      var _this9 = this;

      return __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(rootParameter.dependentParams).map(function (paramName) {
        return _this9.parameterMap.get(paramName);
      }).flatMap(function (parameter) {
        return __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].of(parameter).concat(_this9._getDeepParameterDependencies(parameter));
      });
    }

    /**
     * Fetch answer value for each group of parameters and update state with
     * counts. Default values will be used for parameters in groups to the right
     * of each group, and user supplied values will be used for the rest.
     *
     * @param {Iterable<Group>} groups
     */

  }, {
    key: '_updateGroupCounts',
    value: function _updateGroupCounts(groups) {
      var _this10 = this;

      // set loading state for group counts
      var groupUIState = groups.reduce(function (state, group) {
        return Object.assign(state, _defineProperty({}, group.name, Object.assign({}, state[group.name], {
          loading: true,
          // XXX Why are we setting valid true here?
          valid: false
        })));
      }, Object.assign({}, this.state.groupUIState));

      this.setState({ groupUIState: groupUIState });

      var defaultParamValues = Object(__WEBPACK_IMPORTED_MODULE_13__util_QuestionWizardState__["b" /* getDefaultParamValues */])(this.state);

      // transform each group into an answer value promise with accumulated param
      // values of previous groups
      var stateByGroup = __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(groups).map(function (group) {
        return __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(_this10.state.question.groups).takeWhile(function (g) {
          return g !== group;
        }).concat(__WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].of(group));
      }).map(function (groups) {
        return [groups.last(), {
          questionName: _this10.state.question.name,
          parameters: groups.reduce(function (paramValues, group) {
            return group.parameters.reduce(function (paramValues, paramName) {
              return Object.assign(paramValues, _defineProperty({}, paramName, _this10.state.paramValues[paramName]));
            }, paramValues);
          }, Object.assign({}, defaultParamValues))
        }];
      }).map(function (_ref8) {
        var _ref9 = _slicedToArray(_ref8, 2),
            group = _ref9[0],
            answerSpec = _ref9[1];

        var params = group.parameters.map(function (paramName) {
          return _this10.parameterMap.get(paramName);
        });
        // TODO Use countPredictsAnswerCount FilterParamNew property
        return (params.length === 1 && params[0].type === 'FilterParamNew' ? _this10._getFilterCounts(params[0].name, JSON.parse(_this10.state.paramValues[params[0].name]).filters, answerSpec.parameters).then(function (counts) {
          return counts.filtered;
        }) : _this10._getAnswerCount(answerSpec)).then(function (totalCount) {
          return [group, { accumulatedTotal: totalCount, valid: true, loading: false }];
        }, function (error) {
          console.error('Error loading group count for %o.', group, error);
          return [group, { valid: false, loading: false }];
        }).then(function (_ref10) {
          var _ref11 = _slicedToArray(_ref10, 2),
              group = _ref11[0],
              state = _ref11[1];

          var groupUIState = Object.assign({}, _this10.state.groupUIState, _defineProperty({}, group.name, Object.assign({}, _this10.state.groupUIState[group.name], state)));
          _this10.setState({ groupUIState: groupUIState });
        });
      });

      return Promise.all(stateByGroup);
    }
  }, {
    key: '_getAnswerCount',
    value: function _getAnswerCount(answerSpec) {
      var _this11 = this;

      var formatting = {
        formatConfig: {
          pagination: { offset: 0, numRecords: 0 }
        }
      };
      return this.props.wdkService.getAnswer(answerSpec, formatting).then(function (answer) {
        return answer.meta.totalCount;
      }, function (error) {
        _this11.setState({ error: error });
      });
    }
  }, {
    key: '_getFilterCounts',
    value: function _getFilterCounts(paramName, filters, paramValues) {
      return this.props.wdkService.getFilterParamSummaryCounts(this.state.question.urlSegment, paramName, filters, paramValues);
    }
  }, {
    key: '_updateFilterParamCounts',
    value: function _updateFilterParamCounts(paramName, filters) {
      var _this12 = this;

      return this._getFilterCounts(paramName, filters, this.state.paramValues).then(function (counts) {
        var uiState = _this12.state.paramUIState[paramName];
        _this12.setState(updateState(['paramUIState', paramName], Object.assign({}, uiState, {
          filteredCount: counts.filtered,
          unfilteredCount: counts.unfiltered
        })));
      }, function (error) {
        _this12.setState({ error: error });
      });
    }
  }, {
    key: '_updateOntologyTermSummary',
    value: function _updateOntologyTermSummary(paramName, ontologyTerm, filters) {
      var _this13 = this;

      return this.props.wdkService.getOntologyTermSummary(this.state.question.urlSegment, paramName, filters.filter(function (filter) {
        return filter.field !== ontologyTerm;
      }), ontologyTerm, this.state.paramValues).then(function (ontologyTermSummary) {
        var _state$paramUIState$p = _this13.state.paramUIState[paramName],
            defaultMemberFieldState = _state$paramUIState$p.defaultMemberFieldState,
            fieldStates = _state$paramUIState$p.fieldStates,
            ontologyTermSummaries = _state$paramUIState$p.ontologyTermSummaries;

        var fieldState = fieldStates[ontologyTerm] || defaultMemberFieldState;

        ontologyTermSummary.valueCounts = sortDistribution(ontologyTermSummary.valueCounts, fieldState.sort, filters);

        _this13.setState(updateState(['paramUIState', paramName, 'fieldStates'], Object.assign({}, fieldStates, _defineProperty({}, ontologyTerm, fieldState))));

        _this13.setState(updateState(['paramUIState', paramName, 'ontologyTermSummaries'], Object.assign({}, ontologyTermSummaries, _defineProperty({}, ontologyTerm, ontologyTermSummary))));
      }, function (error) {
        _this13.setState({ error: error });
      });
    }
  }, {
    key: '_getParamUIState',
    value: function _getParamUIState(state, paramName) {
      return state.paramUIState[paramName];
    }
  }, {
    key: '_groupHasCount',
    value: function _groupHasCount(group) {
      return this.state.groupUIState[group.name].accumulatedTotal != null;
    }
  }, {
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.loadQuestion(this.props);

      // FIXME Figure out to render form element in `QuestionWizard` component
      var $form = __WEBPACK_IMPORTED_MODULE_0_jquery___default()(__WEBPACK_IMPORTED_MODULE_5_react_dom___default.a.findDOMNode(this)).closest('form');
      $form.on('submit', function () {
        $form.block();
      }).on(wdk.addStepPopup.SUBMIT_EVENT, function () {
        $form.block();
      }).on(wdk.addStepPopup.CANCEL_EVENT, function () {
        $form.unblock();
      }).prop('autocomplete', 'off').attr('novalidate', '');
    }
  }, {
    key: 'componentDidWillReceiveProps',
    value: function componentDidWillReceiveProps(nextProps) {
      this.loadQuestion(nextProps);
    }
  }, {
    key: 'render',
    value: function render() {
      var _this14 = this;

      return __WEBPACK_IMPORTED_MODULE_4_react___default.a.createElement(
        'div',
        null,
        this.state.error && __WEBPACK_IMPORTED_MODULE_4_react___default.a.createElement(
          __WEBPACK_IMPORTED_MODULE_6_wdk_client_Components__["Dialog"],
          { open: true, modal: true, title: 'An error occurred', onClose: function onClose() {
              return _this14.setState({ error: undefined });
            } },
          __WEBPACK_IMPORTED_MODULE_9_wdk_client_IterableUtils__["Seq"].from(this.state.error.stack.split('\n')).flatMap(function (line) {
            return [line, __WEBPACK_IMPORTED_MODULE_4_react___default.a.createElement('br', null)];
          })
        ),
        this.state.question && __WEBPACK_IMPORTED_MODULE_4_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_12__components_QuestionWizard__["default"], {
          eventHandlers: this.eventHandlers,
          wizardState: this.state,
          customName: this.props.customName,
          isAddingStep: this.props.isAddingStep,
          showHelpText: !this.props.isRevise
        })
      );
    }
  }]);

  return QuestionWizardController;
}(__WEBPACK_IMPORTED_MODULE_8_wdk_client_Controllers__["AbstractViewController"]);

QuestionWizardController.propTypes = {
  wdkService: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.object.isRequired,
  questionName: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.string.isRequired,
  paramValues: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.object.isRequired,
  isRevise: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.bool.isRequired,
  isAddingStep: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.bool.isRequired,
  customName: __WEBPACK_IMPORTED_MODULE_3_prop_types___default.a.string
};

QuestionWizardController.defaultProps = {
  get wdkService() {
    return window.ebrc.context.wdkService;
  }
};

/* harmony default export */ __webpack_exports__["default"] = (Object(__WEBPACK_IMPORTED_MODULE_7_wdk_client_ComponentUtils__["wrappable"])(QuestionWizardController));

/**
 * Creates an updater function that returns a new state object
 * with an updated value at the specified path.
 */
function updateState(path, value) {
  return function update(state) {
    return updateObjectImmutably(state, path, value);
  };
}

/**
 * Creates a new object based on input object with an updated value
 * a the specified path.
 */
function updateObjectImmutably(object, _ref12, value) {
  var _ref13 = _toArray(_ref12),
      key = _ref13[0],
      restPath = _ref13.slice(1);

  var isObject = (typeof object === 'undefined' ? 'undefined' : _typeof(object)) === 'object';
  if (!isObject || isObject && !(key in object)) throw new Error("Invalid key path");

  return Object.assign({}, object, _defineProperty({}, key, restPath.length === 0 ? value : updateObjectImmutably(object[key], restPath, value)));
}

/**
 * Compare distribution values using a natural comparison algorithm.
 * @param {string|null} valueA
 * @param {string|null} valueB
 */
function compareDistributionValues(valueA, valueB) {
  return natSortComparator(valueA == null ? '' : valueA, valueB == null ? '' : valueB);
}

function filteredCountIsZero(entry) {
  return entry.filteredCount === 0;
}

/**
 * Sort distribution based on sort spec. `SortSpec` is an object with two
 * properties: `columnKey` (the distribution property to sort by), and
 * `direction` (one of 'asc' or 'desc').
 * @param {Distribution} distribution
 * @param {SortSpec} sort
 */
function sortDistribution(distribution, sort, filter) {
  var columnKey = sort.columnKey,
      direction = sort.direction,
      groupBySelected = sort.groupBySelected;

  var selectedSet = new Set(filter ? filter.value : []);
  var selectionPred = groupBySelected ? function (a) {
    return !selectedSet.has(a.value);
  } : __WEBPACK_IMPORTED_MODULE_1_lodash__["stubTrue"];

  // first sort by specified column
  var sortedDist = distribution.slice().sort(function compare(a, b) {
    var order =
    // if a and b are equal, fall back to comparing `value`
    columnKey === 'value' || a[columnKey] === b[columnKey] ? compareDistributionValues(a.value, b.value) : a[columnKey] > b[columnKey] ? 1 : -1;
    return direction === 'desc' ? -order : order;
  });

  // then perform secondary sort based on filtered count and selection
  return Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["sortBy"])(sortedDist, [filteredCountIsZero, selectionPred]);
}
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 65 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react_dom__ = __webpack_require__(19);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react_dom___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react_dom__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/**
 * Created by dfalke on 8/24/16.
 */



var visibleStyle = {
  color: 'white',
  background: 'rgba(0, 0, 0, 0.19)',
  border: 'none',
  outline: 'none',
  padding: '8px',
  position: 'fixed',
  bottom: '85px',
  right: '16px',
  zIndex: 1000,
  opacity: 1,
  visibility: 'visible',
  transition: 'background .5s, opacity .5s, visibility .5s'
};

var hoverStyle = Object.assign({}, visibleStyle, {
  background: 'rgba(0, 0, 0, 0.5)'
});

var hiddenStyle = Object.assign({}, visibleStyle, {
  opacity: 0,
  visibility: 'hidden'
});

var scrollToTop = function scrollToTop() {
  location.hash = '';
  window.scrollTo(window.scrollX, 0);
};

var ScrollToTop = function ScrollToTop(_ref) {
  var style = _ref.style;
  return React.createElement(
    'button',
    {
      type: 'button',
      style: style,
      onClick: scrollToTop,
      onMouseEnter: renderScrollToTopWithHover,
      onMouseLeave: renderScrollToTopWithOutHover,
      title: 'Go back to the top of the page.'
    },
    React.createElement('i', { className: 'fa fa-2x fa-arrow-up' })
  );
};

var getDomNode = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["once"])(function () {
  return document.body.appendChild(document.createElement('div'));
});

var renderScrollToTop = function renderScrollToTop(style) {
  return Object(__WEBPACK_IMPORTED_MODULE_0_react_dom__["render"])(React.createElement(ScrollToTop, { style: window.scrollY > 250 ? style : hiddenStyle }), getDomNode());
};

var renderScrollToTopWithHover = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["partial"])(renderScrollToTop, hoverStyle);

var renderScrollToTopWithOutHover = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["partial"])(renderScrollToTop, visibleStyle);

window.addEventListener('scroll', Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["throttle"])(renderScrollToTopWithOutHover, 250));

/***/ }),
/* 66 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_eupathdb_wdkCustomization_css_client_css__ = __webpack_require__(67);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_eupathdb_wdkCustomization_css_client_css___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_eupathdb_wdkCustomization_css_client_css__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_eupathdb_wdkCustomization_js_client_bootstrap__ = __webpack_require__(68);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__mainMenuItems__ = __webpack_require__(97);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__smallMenuItems__ = __webpack_require__(98);





var quickSearches = [{
  name: 'GroupQuestions.ByTextSearch',
  paramName: 'text_expression',
  displayName: 'Groups Quick Search',
  help: 'Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on \'Groups Quick Search\' to access the advanced group search page.'
}, {
  name: 'SequenceQuestions.ByTextSearch',
  paramName: 'text_expression',
  displayName: 'Sequences Quick Search',
  help: 'Use * as a wildcard, as in *inase, kin*se, kinas*. Do not use AND, OR. Use quotation marks to find an exact phrase. Click on \'Sequences Quick Search\' to access the advanced sequence search page.'
}];

Object(__WEBPACK_IMPORTED_MODULE_1_eupathdb_wdkCustomization_js_client_bootstrap__["a" /* initialize */])({
  includeQueryGrid: false,
  mainMenuItems: __WEBPACK_IMPORTED_MODULE_2__mainMenuItems__["a" /* default */],
  smallMenuItems: __WEBPACK_IMPORTED_MODULE_3__smallMenuItems__["a" /* default */],
  quickSearches: quickSearches
});

/***/ }),
/* 67 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),
/* 68 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(console) {/* harmony export (immutable) */ __webpack_exports__["a"] = initialize;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__config__ = __webpack_require__(21);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client__ = __webpack_require__(3);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__actioncreators_GlobalActionCreators__ = __webpack_require__(56);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__component_wrappers__ = __webpack_require__(75);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__store_wrappers__ = __webpack_require__(87);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__components__ = __webpack_require__(14);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6__components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_6__components__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__controllers__ = __webpack_require__(11);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7__controllers___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7__controllers__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_8__routes__ = __webpack_require__(96);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_9__js_scroll_to_top__ = __webpack_require__(65);
var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

// Bootstrap the WDK client application
// ====================================

// placeholder used by webpack when making xhr's for code chunks
__webpack_require__.p = window.__asset_path_remove_me_please__; // eslint-disable-line

// TODO Remove auth_tkt from url before proceeding












// include scroll to top button


/**
 * Initialize and run application
 *
 * @param {Object} [options]
 * @param {Object} [options.componentWrappers] An object whose keys are Wdk
 *    Component names, and whose values are higer-order Component functions.
 * @param {Object} [options.storeWrappers] An object whose keys are Wdk Store
 *    names, and whose values are higher-order Store functions.
 * @param {Array} [options.quickSearches] An array of quick search reference
 *    objects. A quick search refrence object has the following structure:
 *      {
 *        // Full Question name used to process the search
 *        name: string;
 *
 *        // Alternate full Question name to use as a hyperlink
 *        alternate: string;
 *
 *        // The name of the param to use for the text input
 *        paramName: string;
 *
 *        // The name to display next to the text input
 *        displayName: string;
 *
 *        // Text to display in the tooltip
 *        help: string;
 *      }
 * @param {Function} [options.wrapRoutes] A function that takes a Routes object
 *    and returns a new Routes object. Use this as an opportunity alter routes.
 * @param {boolean} [options.isPartOfEuPathDB = false] Controls if the EuPathDB
 *    logo is displayed. Defaults to `false`.
 * @param {boolean} [options.flattenSearches = false] Controls if the search
 *    menu searches is displayed nested according to the ontology, or as a flat
 *    list.
 * @param {boolean} [options.includeQueryGrid = false] Controls if a link to
 *    the query grid page is included in the search menu.
 * @param {Function} [options.mainMenuItems] A funtion that returns an Array of
 *    MenuItem objects. A MenuItem object has the following structure:
 *      {
 *        // Used as a modifier for the CSS classes associated with the item
 *        id: string;
 *
 *        // Text used to display the item. Can include HTML
 *        text: string;
 *
 *        // Url to link to (relative to the webapp base url)
 *        webAppUrl: string;
 *
 *        // Absolute url to link to
 *        url: string;
 *
 *        // Route url to link to
 *        route: string;
 *
 *        // Controls if a beta badge is added to item
 *        beta: boolean;
 *
 *        // Controls if a new badge is added to item
 *        new: boolean;
 *
 *        // Array of project_ids that should include the item
 *        include: string[];
 *
 *        // Array of project_ids that should exclude the item. `include` takes precedence.
 *        exclude: string[];
 *
 *        // Click event handler to call when item is clicked
 *        onClick: (event: MouseEvent) => void;
 *
 *        // Controls if the destination of the item requires a user to be logged in
 *        loginRequired: boolean;
 *
 *        // Submenu items
 *        children: MenuItem[];
 *      }
 *    The function is called with two arguments: props passed to `SiteHeader`,
 *    and on object containing preconfigured menu items.
 * @param {Function} [options.smallMenuItems] See `mainMenuItems`.
 */
function initialize() {
  var options = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
  var quickSearches = options.quickSearches,
      componentWrappers = options.componentWrappers,
      storeWrappers = options.storeWrappers,
      _options$wrapRoutes = options.wrapRoutes,
      wrapRoutes = _options$wrapRoutes === undefined ? __WEBPACK_IMPORTED_MODULE_2_lodash__["identity"] : _options$wrapRoutes;


  var restOptions = Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["omit"])(options, ['quickSearches', 'componentWrappers', 'storeWrappers', 'wrapRoutes']);

  unaliasWebappUrl();
  removeJsessionid();

  wrapComponents(mergeWrapperObjects(componentWrappers, __WEBPACK_IMPORTED_MODULE_4__component_wrappers__));

  // initialize the application
  var context = Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client__["initialize"])({
    wrapRoutes: Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["flow"])(__WEBPACK_IMPORTED_MODULE_8__routes__["a" /* wrapRoutes */], wrapRoutes),
    storeWrappers: mergeWrapperObjects(storeWrappers, __WEBPACK_IMPORTED_MODULE_5__store_wrappers__),
    rootUrl: __WEBPACK_IMPORTED_MODULE_0__config__["rootUrl"],
    rootElement: __WEBPACK_IMPORTED_MODULE_0__config__["rootElement"],
    endpoint: __WEBPACK_IMPORTED_MODULE_0__config__["endpoint"],
    onLocationChange: makeLocationHandler()
  });

  (window.ebrc || (window.ebrc = {})).context = context;

  context.dispatchAction(Object(__WEBPACK_IMPORTED_MODULE_3__actioncreators_GlobalActionCreators__["f" /* loadSiteConfig */])(Object.assign({}, __WEBPACK_IMPORTED_MODULE_0__config__, restOptions, {
    quickSearchReferences: quickSearches
  })));

  // XXX Move calls to dispatchAction to controller override?

  // load quick search data
  if (quickSearches) {
    context.dispatchAction(Object(__WEBPACK_IMPORTED_MODULE_3__actioncreators_GlobalActionCreators__["e" /* loadQuickSearches */])(quickSearches));
  }

  context.dispatchAction(Object(__WEBPACK_IMPORTED_MODULE_3__actioncreators_GlobalActionCreators__["d" /* loadBasketCounts */])());

  return context;
}

/**
 * Replace apache alaias `/a` with the webapp url.
 */
function unaliasWebappUrl() {
  if (__WEBPACK_IMPORTED_MODULE_0__config__["rootUrl"]) {
    // replace '/a/' with '/${webapp}/'
    var pathname = window.location.pathname;
    var aliasUrl = __WEBPACK_IMPORTED_MODULE_0__config__["rootUrl"].replace(/^\/[^/]+\/(.*)$/, '/a/$1');
    if (pathname.startsWith(aliasUrl)) {
      window.history.replaceState(null, '', pathname.replace(aliasUrl, __WEBPACK_IMPORTED_MODULE_0__config__["rootUrl"]));
    }
  }
}

/**
 * Remove ;jsessionid=... from url, since it breaks some pages.
 */
function removeJsessionid() {
  // remove jsessionid from url
  window.history.replaceState(null, '', window.location.pathname.replace(/;jsessionid=\w{32}/i, '') + window.location.search + window.location.hash);
}

/** Create location handler */
function makeLocationHandler() {
  // save previousLocation so we can conditionally send pageview events
  var previousLocation = void 0;

  /** Send pageview events to Google Analytics */
  return Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["debounce"])(function onLocationChange(location) {
    // skip if google analytics object is not defined
    if (!window.ga) return;

    // skip if the previous pathname and new pathname are the same, since
    // hash changes are currently detected.
    if (previousLocation && previousLocation.pathname === location.pathname) return;

    // update previousLocation
    previousLocation = location;

    window.ga('send', 'pageview', {
      page: location.pathname,
      title: location.pathname
    });
  }, 1000);
}

/**
 * Merge site wrapper object and ebrc wrapper object, returning a new wrapper
 * object that will be passed to Wdk. ebrc wrappers are applied before site
 * wrappers.
 */
function mergeWrapperObjects(siteWrapperObject, ebrcWrapperObject) {
  var siteIsNull = siteWrapperObject == null;
  var ebrcIsNull = ebrcWrapperObject == null;

  if (siteIsNull && ebrcIsNull) return {};
  if (siteIsNull) return ebrcWrapperObject;
  if (ebrcIsNull) return siteWrapperObject;

  var siteKeys = Object.keys(siteWrapperObject);
  var ebrcKeys = Object.keys(ebrcWrapperObject);
  return Object(__WEBPACK_IMPORTED_MODULE_2_lodash__["uniq"])(siteKeys.concat(ebrcKeys)).reduce(function mergeWrappers(mergedWrappers, key) {
    return Object.assign(mergedWrappers, _defineProperty({}, key, composeWrappers(siteWrapperObject[key], ebrcWrapperObject[key])));
  }, {});
}

/**
 * Creates a wrapper function that composes a site wrapper and an ebrc wrapper.
 * The ebrc wrapper is applied before the site wrapper.
 */
function composeWrappers() {
  var siteWrapper = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : __WEBPACK_IMPORTED_MODULE_2_lodash__["identity"];
  var ebrcWrapper = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : __WEBPACK_IMPORTED_MODULE_2_lodash__["identity"];

  return function (wdkEntity) {
    return siteWrapper(ebrcWrapper(wdkEntity));
  };
}

/**
 * Apply component wrappers.
 */
function wrapComponents(wrappersByComponentName) {
  if (wrappersByComponentName == null) return;
  Object.entries(wrappersByComponentName).forEach(function (_ref) {
    var _ref2 = _slicedToArray(_ref, 2),
        componentName = _ref2[0],
        componentWrapper = _ref2[1];

    var Component = __WEBPACK_IMPORTED_MODULE_1_wdk_client__["Components"][componentName] || __WEBPACK_IMPORTED_MODULE_1_wdk_client__["Controllers"][componentName] || __WEBPACK_IMPORTED_MODULE_6__components__[componentName] || __WEBPACK_IMPORTED_MODULE_7__controllers__[componentName];

    if (Component == null) {
      console.warn('Skipping unknown component wrapper `%s`.', componentName);
    } else if (typeof Component.wrapComponent !== 'function') {
      console.warn('Warning: Component `%s` is not wrappable. Default version will be used.', componentName);
    } else {
      try {
        Component.wrapComponent(componentWrapper);
      } catch (error) {
        console.error('Could not apply component wrapper `%s`.', componentName, error);
      }
    }
  });
}
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 69 */
/***/ (function(module, exports) {

// shim for using process in browser
var process = module.exports = {};

// cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
    throw new Error('setTimeout has not been defined');
}
function defaultClearTimeout () {
    throw new Error('clearTimeout has not been defined');
}
(function () {
    try {
        if (typeof setTimeout === 'function') {
            cachedSetTimeout = setTimeout;
        } else {
            cachedSetTimeout = defaultSetTimout;
        }
    } catch (e) {
        cachedSetTimeout = defaultSetTimout;
    }
    try {
        if (typeof clearTimeout === 'function') {
            cachedClearTimeout = clearTimeout;
        } else {
            cachedClearTimeout = defaultClearTimeout;
        }
    } catch (e) {
        cachedClearTimeout = defaultClearTimeout;
    }
} ())
function runTimeout(fun) {
    if (cachedSetTimeout === setTimeout) {
        //normal enviroments in sane situations
        return setTimeout(fun, 0);
    }
    // if setTimeout wasn't available but was latter defined
    if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
        cachedSetTimeout = setTimeout;
        return setTimeout(fun, 0);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedSetTimeout(fun, 0);
    } catch(e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
            return cachedSetTimeout.call(null, fun, 0);
        } catch(e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
            return cachedSetTimeout.call(this, fun, 0);
        }
    }


}
function runClearTimeout(marker) {
    if (cachedClearTimeout === clearTimeout) {
        //normal enviroments in sane situations
        return clearTimeout(marker);
    }
    // if clearTimeout wasn't available but was latter defined
    if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
        cachedClearTimeout = clearTimeout;
        return clearTimeout(marker);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedClearTimeout(marker);
    } catch (e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
            return cachedClearTimeout.call(null, marker);
        } catch (e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
            // Some versions of I.E. have different rules for clearTimeout vs setTimeout
            return cachedClearTimeout.call(this, marker);
        }
    }



}
var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
    if (!draining || !currentQueue) {
        return;
    }
    draining = false;
    if (currentQueue.length) {
        queue = currentQueue.concat(queue);
    } else {
        queueIndex = -1;
    }
    if (queue.length) {
        drainQueue();
    }
}

function drainQueue() {
    if (draining) {
        return;
    }
    var timeout = runTimeout(cleanUpNextTick);
    draining = true;

    var len = queue.length;
    while(len) {
        currentQueue = queue;
        queue = [];
        while (++queueIndex < len) {
            if (currentQueue) {
                currentQueue[queueIndex].run();
            }
        }
        queueIndex = -1;
        len = queue.length;
    }
    currentQueue = null;
    draining = false;
    runClearTimeout(timeout);
}

process.nextTick = function (fun) {
    var args = new Array(arguments.length - 1);
    if (arguments.length > 1) {
        for (var i = 1; i < arguments.length; i++) {
            args[i - 1] = arguments[i];
        }
    }
    queue.push(new Item(fun, args));
    if (queue.length === 1 && !draining) {
        runTimeout(drainQueue);
    }
};

// v8 likes predictible objects
function Item(fun, array) {
    this.fun = fun;
    this.array = array;
}
Item.prototype.run = function () {
    this.fun.apply(null, this.array);
};
process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues
process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) { return [] }

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};
process.umask = function() { return 0; };


/***/ }),
/* 70 */
/***/ (function(module, exports) {

module.exports = function isBuffer(arg) {
  return arg && typeof arg === 'object'
    && typeof arg.copy === 'function'
    && typeof arg.fill === 'function'
    && typeof arg.readUInt8 === 'function';
}

/***/ }),
/* 71 */
/***/ (function(module, exports) {

if (typeof Object.create === 'function') {
  // implementation from standard node.js 'util' module
  module.exports = function inherits(ctor, superCtor) {
    ctor.super_ = superCtor
    ctor.prototype = Object.create(superCtor.prototype, {
      constructor: {
        value: ctor,
        enumerable: false,
        writable: true,
        configurable: true
      }
    });
  };
} else {
  // old school shim for old browsers
  module.exports = function inherits(ctor, superCtor) {
    ctor.super_ = superCtor
    var TempCtor = function () {}
    TempCtor.prototype = superCtor.prototype
    ctor.prototype = new TempCtor()
    ctor.prototype.constructor = ctor
  }
}


/***/ }),
/* 72 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(global) {

// compare and isBuffer taken from https://github.com/feross/buffer/blob/680e9e5e488f22aac27599a57dc844a6315928dd/index.js
// original notice:

/*!
 * The buffer module from node.js, for the browser.
 *
 * @author   Feross Aboukhadijeh <feross@feross.org> <http://feross.org>
 * @license  MIT
 */
function compare(a, b) {
  if (a === b) {
    return 0;
  }

  var x = a.length;
  var y = b.length;

  for (var i = 0, len = Math.min(x, y); i < len; ++i) {
    if (a[i] !== b[i]) {
      x = a[i];
      y = b[i];
      break;
    }
  }

  if (x < y) {
    return -1;
  }
  if (y < x) {
    return 1;
  }
  return 0;
}
function isBuffer(b) {
  if (global.Buffer && typeof global.Buffer.isBuffer === 'function') {
    return global.Buffer.isBuffer(b);
  }
  return !!(b != null && b._isBuffer);
}

// based on node assert, original notice:

// http://wiki.commonjs.org/wiki/Unit_Testing/1.0
//
// THIS IS NOT TESTED NOR LIKELY TO WORK OUTSIDE V8!
//
// Originally from narwhal.js (http://narwhaljs.org)
// Copyright (c) 2009 Thomas Robinson <280north.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the 'Software'), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

var util = __webpack_require__(55);
var hasOwn = Object.prototype.hasOwnProperty;
var pSlice = Array.prototype.slice;
var functionsHaveNames = (function () {
  return function foo() {}.name === 'foo';
}());
function pToString (obj) {
  return Object.prototype.toString.call(obj);
}
function isView(arrbuf) {
  if (isBuffer(arrbuf)) {
    return false;
  }
  if (typeof global.ArrayBuffer !== 'function') {
    return false;
  }
  if (typeof ArrayBuffer.isView === 'function') {
    return ArrayBuffer.isView(arrbuf);
  }
  if (!arrbuf) {
    return false;
  }
  if (arrbuf instanceof DataView) {
    return true;
  }
  if (arrbuf.buffer && arrbuf.buffer instanceof ArrayBuffer) {
    return true;
  }
  return false;
}
// 1. The assert module provides functions that throw
// AssertionError's when particular conditions are not met. The
// assert module must conform to the following interface.

var assert = module.exports = ok;

// 2. The AssertionError is defined in assert.
// new assert.AssertionError({ message: message,
//                             actual: actual,
//                             expected: expected })

var regex = /\s*function\s+([^\(\s]*)\s*/;
// based on https://github.com/ljharb/function.prototype.name/blob/adeeeec8bfcc6068b187d7d9fb3d5bb1d3a30899/implementation.js
function getName(func) {
  if (!util.isFunction(func)) {
    return;
  }
  if (functionsHaveNames) {
    return func.name;
  }
  var str = func.toString();
  var match = str.match(regex);
  return match && match[1];
}
assert.AssertionError = function AssertionError(options) {
  this.name = 'AssertionError';
  this.actual = options.actual;
  this.expected = options.expected;
  this.operator = options.operator;
  if (options.message) {
    this.message = options.message;
    this.generatedMessage = false;
  } else {
    this.message = getMessage(this);
    this.generatedMessage = true;
  }
  var stackStartFunction = options.stackStartFunction || fail;
  if (Error.captureStackTrace) {
    Error.captureStackTrace(this, stackStartFunction);
  } else {
    // non v8 browsers so we can have a stacktrace
    var err = new Error();
    if (err.stack) {
      var out = err.stack;

      // try to strip useless frames
      var fn_name = getName(stackStartFunction);
      var idx = out.indexOf('\n' + fn_name);
      if (idx >= 0) {
        // once we have located the function frame
        // we need to strip out everything before it (and its line)
        var next_line = out.indexOf('\n', idx + 1);
        out = out.substring(next_line + 1);
      }

      this.stack = out;
    }
  }
};

// assert.AssertionError instanceof Error
util.inherits(assert.AssertionError, Error);

function truncate(s, n) {
  if (typeof s === 'string') {
    return s.length < n ? s : s.slice(0, n);
  } else {
    return s;
  }
}
function inspect(something) {
  if (functionsHaveNames || !util.isFunction(something)) {
    return util.inspect(something);
  }
  var rawname = getName(something);
  var name = rawname ? ': ' + rawname : '';
  return '[Function' +  name + ']';
}
function getMessage(self) {
  return truncate(inspect(self.actual), 128) + ' ' +
         self.operator + ' ' +
         truncate(inspect(self.expected), 128);
}

// At present only the three keys mentioned above are used and
// understood by the spec. Implementations or sub modules can pass
// other keys to the AssertionError's constructor - they will be
// ignored.

// 3. All of the following functions must throw an AssertionError
// when a corresponding condition is not met, with a message that
// may be undefined if not provided.  All assertion methods provide
// both the actual and expected values to the assertion error for
// display purposes.

function fail(actual, expected, message, operator, stackStartFunction) {
  throw new assert.AssertionError({
    message: message,
    actual: actual,
    expected: expected,
    operator: operator,
    stackStartFunction: stackStartFunction
  });
}

// EXTENSION! allows for well behaved errors defined elsewhere.
assert.fail = fail;

// 4. Pure assertion tests whether a value is truthy, as determined
// by !!guard.
// assert.ok(guard, message_opt);
// This statement is equivalent to assert.equal(true, !!guard,
// message_opt);. To test strictly for the value true, use
// assert.strictEqual(true, guard, message_opt);.

function ok(value, message) {
  if (!value) fail(value, true, message, '==', assert.ok);
}
assert.ok = ok;

// 5. The equality assertion tests shallow, coercive equality with
// ==.
// assert.equal(actual, expected, message_opt);

assert.equal = function equal(actual, expected, message) {
  if (actual != expected) fail(actual, expected, message, '==', assert.equal);
};

// 6. The non-equality assertion tests for whether two objects are not equal
// with != assert.notEqual(actual, expected, message_opt);

assert.notEqual = function notEqual(actual, expected, message) {
  if (actual == expected) {
    fail(actual, expected, message, '!=', assert.notEqual);
  }
};

// 7. The equivalence assertion tests a deep equality relation.
// assert.deepEqual(actual, expected, message_opt);

assert.deepEqual = function deepEqual(actual, expected, message) {
  if (!_deepEqual(actual, expected, false)) {
    fail(actual, expected, message, 'deepEqual', assert.deepEqual);
  }
};

assert.deepStrictEqual = function deepStrictEqual(actual, expected, message) {
  if (!_deepEqual(actual, expected, true)) {
    fail(actual, expected, message, 'deepStrictEqual', assert.deepStrictEqual);
  }
};

function _deepEqual(actual, expected, strict, memos) {
  // 7.1. All identical values are equivalent, as determined by ===.
  if (actual === expected) {
    return true;
  } else if (isBuffer(actual) && isBuffer(expected)) {
    return compare(actual, expected) === 0;

  // 7.2. If the expected value is a Date object, the actual value is
  // equivalent if it is also a Date object that refers to the same time.
  } else if (util.isDate(actual) && util.isDate(expected)) {
    return actual.getTime() === expected.getTime();

  // 7.3 If the expected value is a RegExp object, the actual value is
  // equivalent if it is also a RegExp object with the same source and
  // properties (`global`, `multiline`, `lastIndex`, `ignoreCase`).
  } else if (util.isRegExp(actual) && util.isRegExp(expected)) {
    return actual.source === expected.source &&
           actual.global === expected.global &&
           actual.multiline === expected.multiline &&
           actual.lastIndex === expected.lastIndex &&
           actual.ignoreCase === expected.ignoreCase;

  // 7.4. Other pairs that do not both pass typeof value == 'object',
  // equivalence is determined by ==.
  } else if ((actual === null || typeof actual !== 'object') &&
             (expected === null || typeof expected !== 'object')) {
    return strict ? actual === expected : actual == expected;

  // If both values are instances of typed arrays, wrap their underlying
  // ArrayBuffers in a Buffer each to increase performance
  // This optimization requires the arrays to have the same type as checked by
  // Object.prototype.toString (aka pToString). Never perform binary
  // comparisons for Float*Arrays, though, since e.g. +0 === -0 but their
  // bit patterns are not identical.
  } else if (isView(actual) && isView(expected) &&
             pToString(actual) === pToString(expected) &&
             !(actual instanceof Float32Array ||
               actual instanceof Float64Array)) {
    return compare(new Uint8Array(actual.buffer),
                   new Uint8Array(expected.buffer)) === 0;

  // 7.5 For all other Object pairs, including Array objects, equivalence is
  // determined by having the same number of owned properties (as verified
  // with Object.prototype.hasOwnProperty.call), the same set of keys
  // (although not necessarily the same order), equivalent values for every
  // corresponding key, and an identical 'prototype' property. Note: this
  // accounts for both named and indexed properties on Arrays.
  } else if (isBuffer(actual) !== isBuffer(expected)) {
    return false;
  } else {
    memos = memos || {actual: [], expected: []};

    var actualIndex = memos.actual.indexOf(actual);
    if (actualIndex !== -1) {
      if (actualIndex === memos.expected.indexOf(expected)) {
        return true;
      }
    }

    memos.actual.push(actual);
    memos.expected.push(expected);

    return objEquiv(actual, expected, strict, memos);
  }
}

function isArguments(object) {
  return Object.prototype.toString.call(object) == '[object Arguments]';
}

function objEquiv(a, b, strict, actualVisitedObjects) {
  if (a === null || a === undefined || b === null || b === undefined)
    return false;
  // if one is a primitive, the other must be same
  if (util.isPrimitive(a) || util.isPrimitive(b))
    return a === b;
  if (strict && Object.getPrototypeOf(a) !== Object.getPrototypeOf(b))
    return false;
  var aIsArgs = isArguments(a);
  var bIsArgs = isArguments(b);
  if ((aIsArgs && !bIsArgs) || (!aIsArgs && bIsArgs))
    return false;
  if (aIsArgs) {
    a = pSlice.call(a);
    b = pSlice.call(b);
    return _deepEqual(a, b, strict);
  }
  var ka = objectKeys(a);
  var kb = objectKeys(b);
  var key, i;
  // having the same number of owned properties (keys incorporates
  // hasOwnProperty)
  if (ka.length !== kb.length)
    return false;
  //the same set of keys (although not necessarily the same order),
  ka.sort();
  kb.sort();
  //~~~cheap key test
  for (i = ka.length - 1; i >= 0; i--) {
    if (ka[i] !== kb[i])
      return false;
  }
  //equivalent values for every corresponding key, and
  //~~~possibly expensive deep test
  for (i = ka.length - 1; i >= 0; i--) {
    key = ka[i];
    if (!_deepEqual(a[key], b[key], strict, actualVisitedObjects))
      return false;
  }
  return true;
}

// 8. The non-equivalence assertion tests for any deep inequality.
// assert.notDeepEqual(actual, expected, message_opt);

assert.notDeepEqual = function notDeepEqual(actual, expected, message) {
  if (_deepEqual(actual, expected, false)) {
    fail(actual, expected, message, 'notDeepEqual', assert.notDeepEqual);
  }
};

assert.notDeepStrictEqual = notDeepStrictEqual;
function notDeepStrictEqual(actual, expected, message) {
  if (_deepEqual(actual, expected, true)) {
    fail(actual, expected, message, 'notDeepStrictEqual', notDeepStrictEqual);
  }
}


// 9. The strict equality assertion tests strict equality, as determined by ===.
// assert.strictEqual(actual, expected, message_opt);

assert.strictEqual = function strictEqual(actual, expected, message) {
  if (actual !== expected) {
    fail(actual, expected, message, '===', assert.strictEqual);
  }
};

// 10. The strict non-equality assertion tests for strict inequality, as
// determined by !==.  assert.notStrictEqual(actual, expected, message_opt);

assert.notStrictEqual = function notStrictEqual(actual, expected, message) {
  if (actual === expected) {
    fail(actual, expected, message, '!==', assert.notStrictEqual);
  }
};

function expectedException(actual, expected) {
  if (!actual || !expected) {
    return false;
  }

  if (Object.prototype.toString.call(expected) == '[object RegExp]') {
    return expected.test(actual);
  }

  try {
    if (actual instanceof expected) {
      return true;
    }
  } catch (e) {
    // Ignore.  The instanceof check doesn't work for arrow functions.
  }

  if (Error.isPrototypeOf(expected)) {
    return false;
  }

  return expected.call({}, actual) === true;
}

function _tryBlock(block) {
  var error;
  try {
    block();
  } catch (e) {
    error = e;
  }
  return error;
}

function _throws(shouldThrow, block, expected, message) {
  var actual;

  if (typeof block !== 'function') {
    throw new TypeError('"block" argument must be a function');
  }

  if (typeof expected === 'string') {
    message = expected;
    expected = null;
  }

  actual = _tryBlock(block);

  message = (expected && expected.name ? ' (' + expected.name + ').' : '.') +
            (message ? ' ' + message : '.');

  if (shouldThrow && !actual) {
    fail(actual, expected, 'Missing expected exception' + message);
  }

  var userProvidedMessage = typeof message === 'string';
  var isUnwantedException = !shouldThrow && util.isError(actual);
  var isUnexpectedException = !shouldThrow && actual && !expected;

  if ((isUnwantedException &&
      userProvidedMessage &&
      expectedException(actual, expected)) ||
      isUnexpectedException) {
    fail(actual, expected, 'Got unwanted exception' + message);
  }

  if ((shouldThrow && actual && expected &&
      !expectedException(actual, expected)) || (!shouldThrow && actual)) {
    throw actual;
  }
}

// 11. Expected to throw an error:
// assert.throws(block, Error_opt, message_opt);

assert.throws = function(block, /*optional*/error, /*optional*/message) {
  _throws(true, block, error, message);
};

// EXTENSION! This is annoying to write outside this module.
assert.doesNotThrow = function(block, /*optional*/error, /*optional*/message) {
  _throws(false, block, error, message);
};

assert.ifError = function(err) { if (err) throw err; };

var objectKeys = Object.keys || function (obj) {
  var keys = [];
  for (var key in obj) {
    if (hasOwn.call(obj, key)) keys.push(key);
  }
  return keys;
};

/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__(20)))

/***/ }),
/* 73 */
/***/ (function(module, exports) {

module.exports = now

function now() {
    return new Date().getTime()
}


/***/ }),
/* 74 */
/***/ (function(module, exports) {

module.exports = Wdk.StaticDataUtils;

/***/ }),
/* 75 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__DownloadForm__ = __webpack_require__(76);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "DownloadForm", function() { return __WEBPACK_IMPORTED_MODULE_0__DownloadForm__["a"]; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__Footer__ = __webpack_require__(77);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "Footer", function() { return __WEBPACK_IMPORTED_MODULE_1__Footer__["a"]; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__Header__ = __webpack_require__(78);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "Header", function() { return __WEBPACK_IMPORTED_MODULE_2__Header__["a"]; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__RecordHeading__ = __webpack_require__(84);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "RecordHeading", function() { return __WEBPACK_IMPORTED_MODULE_3__RecordHeading__["a"]; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__RecordMainSection__ = __webpack_require__(86);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "RecordMainSection", function() { return __WEBPACK_IMPORTED_MODULE_4__RecordMainSection__["a"]; });






/***/ }),
/* 76 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = DownloadForm;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__util_reporter__ = __webpack_require__(57);



function DownloadForm() {
  return function EupathDownloadForm(props) {
    var Reporter = Object(__WEBPACK_IMPORTED_MODULE_1__util_reporter__["a" /* selectReporterComponent */])(props.selectedReporter, props.recordClass.name);
    return __WEBPACK_IMPORTED_MODULE_0_react__["createElement"](
      'div',
      null,
      __WEBPACK_IMPORTED_MODULE_0_react__["createElement"]('hr', null),
      __WEBPACK_IMPORTED_MODULE_0_react__["createElement"](Reporter, props)
    );
  };
}

/***/ }),
/* 77 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return Footer; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__components_Footer__ = __webpack_require__(33);


var Footer = function Footer() {
  return __WEBPACK_IMPORTED_MODULE_0__components_Footer__["default"];
};

/***/ }),
/* 78 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = Header;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_react__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__util_component__ = __webpack_require__(79);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ActionCreators__ = __webpack_require__(80);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_ActionCreators___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ActionCreators__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__components_SiteHeader__ = __webpack_require__(35);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__components_CookieBanner__ = __webpack_require__(40);







var globalDataItems = ['user', 'ontology', 'recordClasses', 'basketCounts', 'quickSearches', 'preferences', 'location', 'siteConfig'];

var SiteHeaderWithContext = Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["flow"])(Object(__WEBPACK_IMPORTED_MODULE_2__util_component__["a" /* withActions */])(__WEBPACK_IMPORTED_MODULE_3_wdk_client_ActionCreators__["UserActionCreators"]), Object(__WEBPACK_IMPORTED_MODULE_2__util_component__["b" /* withStore */])(function (state) {
  return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["pick"])(state.globalData, globalDataItems);
}))(__WEBPACK_IMPORTED_MODULE_4__components_SiteHeader__["default"]);

/**
 * Wrap Header component with state from store and configured actionCreators
 */
function Header() {
  return function () {
    return __WEBPACK_IMPORTED_MODULE_1_react___default.a.createElement(
      'div',
      null,
      __WEBPACK_IMPORTED_MODULE_1_react___default.a.createElement(SiteHeaderWithContext, null),
      __WEBPACK_IMPORTED_MODULE_1_react___default.a.createElement(__WEBPACK_IMPORTED_MODULE_5__components_CookieBanner__["default"], null)
    );
  };
}

/***/ }),
/* 79 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "b", function() { return withStore; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return withActions; });
/* unused harmony export withPlainTextCopy */
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_prop_types__ = __webpack_require__(5);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_prop_types___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_prop_types__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__ = __webpack_require__(4);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__);
var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/**
 * Created by dfalke on 8/19/16.
 */




/**
 * A function that takes a React Component (class or function) and
 * returns a new React Component. ComponentDecorators are used to
 * enhance the behavior of another Component.
 *
 * Because all ComponentDecorators take a Component and return a
 * new Component, they can be composed using standard function
 * composition. This makes it possible to combine several specialized
 * ComponentDecorators into a single, unique ComponentDecorator.
 *
 * @typedef {Function} ComponentDecorator
 */

/**
 * Creates a React Component decorator that handles subscribing to the store
 * available on the current React context, and passes the store's state to the
 * decorated Component as props. The optional function `getStateFromStore` is
 * used to map the store's state before passing it to the decorated Component.
 *
 * Example:
 * ```
 * // A Header component that requires a user object
 * function Header(props) {
 *   return (
 *     <div>
 *       {...}
 *       <a href="profile">{props.user.fullName}</a>
 *     </div>
 *   );
 * }
 *
 * // Function that gets the user from the store's state.
 * function getUser(state) {
 *   return {
 *     user: state.globalData.user
 *   };
 * }
 *
 * // Decorate the Header component to get the up-to-date user from the store.
 * let HeaderWithStore = withStore(getUser)(Header);
 * ```
 *
 * @param {Function} getStateFromStore Mapping function applied to the store's state. Note:
 *   the store's state should not be modified. Treat the state as immutable.
 * @return {ComponentDecorator}
 */
var withStore = function withStore() {
  var _getStateFromStore = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : __WEBPACK_IMPORTED_MODULE_1_lodash__["identity"];

  return function (TargetComponent) {
    var StoreProvider = function (_PureComponent) {
      _inherits(StoreProvider, _PureComponent);

      function StoreProvider(props, context) {
        _classCallCheck(this, StoreProvider);

        var _this = _possibleConstructorReturn(this, (StoreProvider.__proto__ || Object.getPrototypeOf(StoreProvider)).call(this, props, context));

        _this.state = _this.getStateFromStore(_this.props);
        return _this;
      }

      _createClass(StoreProvider, [{
        key: 'getStateFromStore',
        value: function getStateFromStore(props) {
          return _getStateFromStore(this.context.store.getState(), props);
        }
      }, {
        key: 'componentDidMount',
        value: function componentDidMount() {
          var _this2 = this;

          this.subscription = this.context.store.addListener(function () {
            _this2.setState(_this2.getStateFromStore(_this2.props));
          });
        }
      }, {
        key: 'componentWillReceiveProps',
        value: function componentWillReceiveProps(nextProps) {
          // only update store's state if `getStateFromStore` is using props
          if (_getStateFromStore.length === 2) {
            this.setState(this.getStateFromStore(nextProps));
          }
        }
      }, {
        key: 'componentWillUnmount',
        value: function componentWillUnmount() {
          this.subscription.remove();
        }
      }, {
        key: 'render',
        value: function render() {
          return React.createElement(TargetComponent, _extends({}, this.props, this.state));
        }
      }]);

      return StoreProvider;
    }(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["PureComponent"]);

    StoreProvider.contextTypes = {
      store: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.object.isRequired
    };

    return StoreProvider;
  };
};

/**
 * Creates a Component decorator that passes a set of wrapped action creators
 * to the decorated Component as props of the same name. The action creators are
 * wrapped such that they use the `dispatchAction` function available on the
 * current React context.
 *
 * Example:
 * ```
 * function Header(props) {
 *   return (
 *     //...
 *     <a href="login" onClick={props.onLogin}>Login</a>
 *     //...
 *   );
 * }
 * ```
 *
 * @param {Object} actionCreators An object-map of action creator functions
 * @return {ComponentDecorator}
 */
var withActions = function withActions() {
  var actionCreators = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};
  return function (TargetComponent) {
    var WrappActionCreatorsProvider = function (_PureComponent2) {
      _inherits(WrappActionCreatorsProvider, _PureComponent2);

      function WrappActionCreatorsProvider(props, context) {
        _classCallCheck(this, WrappActionCreatorsProvider);

        var _this3 = _possibleConstructorReturn(this, (WrappActionCreatorsProvider.__proto__ || Object.getPrototypeOf(WrappActionCreatorsProvider)).call(this, props, context));

        _this3.wrappedActionCreators = Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["wrapActions"])(context.dispatchAction, actionCreators);
        return _this3;
      }

      _createClass(WrappActionCreatorsProvider, [{
        key: 'render',
        value: function render() {
          return React.createElement(TargetComponent, _extends({}, this.props, this.wrappedActionCreators));
        }
      }]);

      return WrappActionCreatorsProvider;
    }(__WEBPACK_IMPORTED_MODULE_2_wdk_client_ComponentUtils__["PureComponent"]);

    WrappActionCreatorsProvider.contextTypes = {
      dispatchAction: __WEBPACK_IMPORTED_MODULE_0_prop_types___default.a.func.isRequired
    };

    return WrappActionCreatorsProvider;
  };
};

/**
 * Decorates a component so that when any of part of it is copied, all rich
 * formatting is removed.
 */
var withPlainTextCopy = function withPlainTextCopy(TargetComponent) {
  return function PlainTextCopyWrapper(props) {
    return React.createElement(
      'div',
      { onCopy: handleCopy },
      React.createElement(TargetComponent, props)
    );
  };
};

function handleCopy(event) {
  event.clipboardData.setData('text/plain', window.getSelection().toString());
  event.preventDefault();
}

/***/ }),
/* 80 */
/***/ (function(module, exports) {

module.exports = Wdk.ActionCreators;

/***/ }),
/* 81 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = makeMenuItems;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_lodash__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__ = __webpack_require__(17);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__ = __webpack_require__(18);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__util_category__ = __webpack_require__(82);





/**
 * Map search tree to menu items. If flatten is true, return a flat
 * list of search items. Otherwise, return the full tree of search
 * items.
 */
function getSearchItems(ontology, recordClasses) {
  var flatten = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : false;

  if (ontology == null || recordClasses == null) return [];
  var tree = Object(__WEBPACK_IMPORTED_MODULE_3__util_category__["a" /* getSearchMenuCategoryTree */])(ontology, recordClasses, {});
  return flatten ? Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_TreeUtils__["preorderSeq"])(tree).filter(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__["isIndividual"]).map(createMenuItem) : tree.children.map(createMenuItem);
}

/** Map a search node to a meny entry */
function createMenuItem(searchNode) {
  return {
    id: Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__["getId"])(searchNode),
    text: Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__["getDisplayName"])(searchNode),
    children: searchNode.children.map(createMenuItem),
    webAppUrl: Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__["getTargetType"])(searchNode) === 'search' && '/showQuestion.do?questionFullName=' + Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_CategoryUtils__["getId"])(searchNode)
  };
}

/**
 * Common menu items used by our sites.
 * Some are used in the small menu, and some in the main menu.
 * We collect them here to allow the specific site to decide where and
 * how to use them.
 *
 * This is imperfect, but what it provides is the construction of the most
 * common set of menu items used across our sites, allowing each site to
 * modify or extend the data structure at will.
 *
 * Note, each top-level entry has a unique id. This can be leveraged to alter
 * the final structure of the menu items.
 *
 * @param {object} props Header props
 */
function makeMenuItems(props) {
  var basketCounts = props.basketCounts,
      user = props.user,
      siteConfig = props.siteConfig,
      ontology = props.ontology,
      recordClasses = props.recordClasses,
      showLoginForm = props.showLoginForm,
      showLogoutWarning = props.showLogoutWarning;
  var facebookUrl = siteConfig.facebookUrl,
      twitterUrl = siteConfig.twitterUrl,
      youtubeUrl = siteConfig.youtubeUrl,
      webAppUrl = siteConfig.webAppUrl,
      _siteConfig$includeQu = siteConfig.includeQueryGrid,
      includeQueryGrid = _siteConfig$includeQu === undefined ? true : _siteConfig$includeQu,
      _siteConfig$flattenSe = siteConfig.flattenSearches,
      flattenSearches = _siteConfig$flattenSe === undefined ? false : _siteConfig$flattenSe;


  var totalBasketCount = Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["reduce"])(basketCounts, __WEBPACK_IMPORTED_MODULE_0_lodash__["add"], 0);

  var isLoggedIn = user && !user.isGuest;

  return Object(__WEBPACK_IMPORTED_MODULE_0_lodash__["keyBy"])([{ id: 'home', text: 'Home', tooltip: 'Go to the home page', url: webAppUrl }, { id: 'search', text: 'New Search', tooltip: 'Start a new search strategy',
    children: getSearchItems(ontology, recordClasses, flattenSearches).concat(includeQueryGrid ? [{ id: 'query-grid', text: 'View all available searches', route: '/query-grid' }] : [])
  }, { id: 'strategies', text: 'My Strategies', webAppUrl: '/showApplication.do' }, {
    id: 'basket',
    text: React.createElement(
      'span',
      null,
      'My Basket ',
      React.createElement(
        'span',
        { style: { color: '#600000' } },
        '(',
        totalBasketCount,
        ')'
      )
    ),
    webAppUrl: '/showApplication.do?tab=basket',
    loginRequired: true
  }, {
    id: 'favorites',
    text: 'My Favorites',
    webAppUrl: '/app/favorites',
    loginRequired: true
  }, isLoggedIn ? {
    id: 'profileOrLogin',
    text: user.properties.firstName + ' ' + user.properties.lastName + '\'s Profile',
    route: '/user/profile'
  } : {
    id: 'profileOrLogin',
    text: 'Login',
    url: '#login',
    onClick: function onClick(e) {
      e.preventDefault();showLoginForm();
    }
  }, isLoggedIn ? {
    id: 'registerOrLogout',
    text: 'Logout',
    url: '#logout',
    onClick: function onClick(e) {
      e.preventDefault();showLogoutWarning();
    }
  } : {
    id: 'registerOrLogout',
    text: 'Register',
    route: '/user/registration'
  }, {
    id: 'contactUs',
    text: 'Contact Us',
    webAppUrl: '/contact.do',
    target: '_blank'
  }].concat(twitterUrl ? {
    id: 'twitter',
    liClassName: 'eupathdb-SmallMenuSocialMediaContainer',
    className: 'eupathdb-SocialMedia eupathdb-SocialMedia__twitter',
    url: twitterUrl,
    title: 'Follow us on Twitter!',
    target: '_blank'
  } : []).concat(facebookUrl ? {
    id: 'facebook',
    liClassName: 'eupathdb-SmallMenuSocialMediaContainer',
    className: 'eupathdb-SocialMedia eupathdb-SocialMedia__facebook',
    url: facebookUrl,
    title: 'Follow us on Facebook!',
    target: '_blank'
  } : []).concat(youtubeUrl ? {
    id: 'youtube',
    liClassName: 'eupathdb-SmallMenuSocialMediaContainer',
    className: 'eupathdb-SocialMedia eupathdb-SocialMedia__youtube',
    url: youtubeUrl,
    title: 'Follow us on YouTube!',
    target: '_blank'
  } : []), "id");
}

/***/ }),
/* 82 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = getSearchMenuCategoryTree;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_IterableUtils__ = __webpack_require__(13);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_IterableUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client_IterableUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_TreeUtils__ = __webpack_require__(18);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_wdk_client_TreeUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_wdk_client_TreeUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_OntologyUtils__ = __webpack_require__(54);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2_wdk_client_OntologyUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_2_wdk_client_OntologyUtils__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_CategoryUtils__ = __webpack_require__(17);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_wdk_client_CategoryUtils___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_wdk_client_CategoryUtils__);





var isSearchMenuScope = Object(__WEBPACK_IMPORTED_MODULE_3_wdk_client_CategoryUtils__["isQualifying"])({ targetType: 'search', scope: 'menu' });

/**
 * Gets Category ontology and returns a tree, where each immediate child node
 * is a recordClass. Optionally, indicate record classes to include or exclude
 * via the `options` object. If `options.include` is defined, `options.exclude`
 * will be ignored.
 *
 * This is used by bubbles and query grid (and soon menus).
 *
 * @param {Object} ontology
 * @param {Object[]} recordClasses
 * @param {Object} options?
 * @param {string[]} options.include? Record classes to include
 * @param {string[]} options.exclude? Record classes to exclude
 * @returns Promise<RecordClassTree[]>
 */
function getSearchMenuCategoryTree(ontology, recordClasses, options) {
  var recordClassMap = new Map(recordClasses.map(function (rc) {
    return [rc.name, rc];
  }));
  // get searches scoped for menu
  var categoryTree = Object(__WEBPACK_IMPORTED_MODULE_2_wdk_client_OntologyUtils__["getTree"])(ontology, isSearchMenuScope);
  return groupByRecordClass(categoryTree, recordClassMap, options);
}

/**
 *
 * @param categoryTree
 * @param recordClassMap
 * @param options?
 * @returns {RecordClassTree[]}
 */
function groupByRecordClass(categoryTree, recordClassMap, options) {
  var recordClassCategories = __WEBPACK_IMPORTED_MODULE_0_wdk_client_IterableUtils__["Seq"].from(recordClassMap.keys()).filter(includeExclude(options)).map(function (name) {
    return recordClassMap.get(name);
  }).map(getRecordClassTree(categoryTree)).filter(isDefined).toArray();
  return { children: recordClassCategories };
}

function isDefined(maybe) {
  return maybe !== undefined;
}

function includeExclude() {
  var _ref = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {},
      include = _ref.include,
      exclude = _ref.exclude;

  return function (item) {
    return include != null ? include.indexOf(item) > -1 : exclude != null ? exclude.indexOf(item) === -1 : true;
  };
}

function getRecordClassTree(categoryTree) {
  return function (recordClass) {
    var tree = Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_TreeUtils__["pruneDescendantNodes"])(isRecordClassTreeNode(recordClass), categoryTree);
    if (tree.children.length === 0) return;
    return {
      properties: {
        label: [recordClass.name],
        'EuPathDB alternative term': [recordClass.displayNamePlural]
      },
      // Flatten non-transcript searches. This can be removed if we decide to show
      // those categories
      children: recordClass.name === 'TranscriptRecordClasses.TranscriptRecordClass' ? tree.children : Object(__WEBPACK_IMPORTED_MODULE_1_wdk_client_TreeUtils__["preorderSeq"])(tree).filter(function (n) {
        return n.children.length === 0;
      }).toArray()
    };
  };
}

function isRecordClassTreeNode(recordClass) {
  return function (node) {
    return node.children.length !== 0 || Object(__WEBPACK_IMPORTED_MODULE_3_wdk_client_CategoryUtils__["getRecordClassName"])(node) === recordClass.name;
  };
}

/***/ }),
/* 83 */
/***/ (function(module, exports) {

module.exports = Mesa;

/***/ }),
/* 84 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = RecordHeading;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__util_customElements__ = __webpack_require__(85);


/**
 * Override RecordHeading, and add record_overview attribute value.
 */
function RecordHeading(DefaultComponent) {
  return function EbrcRecordHeading(props) {
    return React.createElement(
      'div',
      null,
      React.createElement(DefaultComponent, props),
      Object(__WEBPACK_IMPORTED_MODULE_0__util_customElements__["a" /* renderWithCustomElements */])(props.record.attributes.record_overview)
    );
  };
}

/***/ }),
/* 85 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* WEBPACK VAR INJECTION */(function(console) {/* unused harmony export registerCustomElement */
/* harmony export (immutable) */ __webpack_exports__["a"] = renderWithCustomElements;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react_dom__ = __webpack_require__(19);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_react_dom___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_react_dom__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react__ = __webpack_require__(1);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_react___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_react__);
var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

/**
 * Register DOM element names to use the provided React Component.
 */




var reactCustomElements = new Map();
var nodeNameRegexp = /^[a-z]+(-[a-z]+)+$/;

/** register a node name with a React Component */
function registerCustomElement(nodeName, reactElementFactory) {
  if (!nodeNameRegexp.test(nodeName)) {
    throw new Error("The nodeName format of `%s` is not acceptable. Only " + "lowercase letters and dashes are allowed, and nodeName " + "must begin and end with a lowercase letter.", nodeName);
  }
  if (reactCustomElements.has(nodeName)) {
    console.error("Warning: A React Component as already been registered with the nodeName `%s`.", nodeName);
    return;
  }
  reactCustomElements.set(nodeName, reactElementFactory);
}

/**
 * Render provided HTML string as a React Component, replacing registered
 * custom elements with associated components.
 */
function renderWithCustomElements(html) {
  return React.createElement(ReactElementsContainer, { html: html });
}

var ReactElementsContainer = function (_Component) {
  _inherits(ReactElementsContainer, _Component);

  function ReactElementsContainer(props) {
    _classCallCheck(this, ReactElementsContainer);

    var _this = _possibleConstructorReturn(this, (ReactElementsContainer.__proto__ || Object.getPrototypeOf(ReactElementsContainer)).call(this, props));

    _this.targets = [];
    return _this;
  }

  _createClass(ReactElementsContainer, [{
    key: 'componentDidMount',
    value: function componentDidMount() {
      this.node.innerHTML = this.props.html;
      var _iteratorNormalCompletion = true;
      var _didIteratorError = false;
      var _iteratorError = undefined;

      try {
        for (var _iterator = reactCustomElements[Symbol.iterator](), _step; !(_iteratorNormalCompletion = (_step = _iterator.next()).done); _iteratorNormalCompletion = true) {
          var _ref = _step.value;

          var _ref2 = _slicedToArray(_ref, 2);

          var nodeName = _ref2[0];
          var reactElementFactory = _ref2[1];
          var _iteratorNormalCompletion2 = true;
          var _didIteratorError2 = false;
          var _iteratorError2 = undefined;

          try {
            for (var _iterator2 = this.node.querySelectorAll(nodeName)[Symbol.iterator](), _step2; !(_iteratorNormalCompletion2 = (_step2 = _iterator2.next()).done); _iteratorNormalCompletion2 = true) {
              var target = _step2.value;

              this.targets.push(target);
              var reactElement = reactElementFactory(target);
              Object(__WEBPACK_IMPORTED_MODULE_0_react_dom__["render"])(reactElement, target);
            }
          } catch (err) {
            _didIteratorError2 = true;
            _iteratorError2 = err;
          } finally {
            try {
              if (!_iteratorNormalCompletion2 && _iterator2.return) {
                _iterator2.return();
              }
            } finally {
              if (_didIteratorError2) {
                throw _iteratorError2;
              }
            }
          }
        }
      } catch (err) {
        _didIteratorError = true;
        _iteratorError = err;
      } finally {
        try {
          if (!_iteratorNormalCompletion && _iterator.return) {
            _iterator.return();
          }
        } finally {
          if (_didIteratorError) {
            throw _iteratorError;
          }
        }
      }
    }
  }, {
    key: 'componentWillUnmount',
    value: function componentWillUnmount() {
      this.targets.forEach(function (target) {
        Object(__WEBPACK_IMPORTED_MODULE_0_react_dom__["unmountComponentAtNode"])(target);
      });
    }
  }, {
    key: 'render',
    value: function render() {
      var _this2 = this;

      return React.createElement('div', { ref: function ref(node) {
          return _this2.node = node;
        } });
    }
  }]);

  return ReactElementsContainer;
}(__WEBPACK_IMPORTED_MODULE_1_react__["Component"]);

ReactElementsContainer.defaultProps = {
  html: ''
};
/* WEBPACK VAR INJECTION */}.call(__webpack_exports__, __webpack_require__(6)))

/***/ }),
/* 86 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = RecordMainSection;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Components__ = __webpack_require__(2);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_wdk_client_Components___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Components__);


function RecordMainSection(DefaultComponent) {
  return function EbrcRecordMainSection(props) {
    return React.createElement(
      'div',
      null,
      React.createElement(DefaultComponent, props),
      !props.depth && 'attribution' in props.record.attributes && React.createElement(
        'div',
        null,
        React.createElement(
          'h3',
          null,
          'Record Attribution'
        ),
        React.createElement(__WEBPACK_IMPORTED_MODULE_0_wdk_client_Components__["RecordAttribute"], {
          attribute: props.recordClass.attributesMap.attribution,
          record: props.record,
          recordClass: props.recordClass
        })
      )
    );
  };
}

/***/ }),
/* 87 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__GlobalDataStoreWrapper__ = __webpack_require__(88);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "GlobalDataStore", function() { return __WEBPACK_IMPORTED_MODULE_0__GlobalDataStoreWrapper__["a"]; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__DownloadFormStoreWrapper__ = __webpack_require__(89);
/* harmony namespace reexport (by provided) */ __webpack_require__.d(__webpack_exports__, "DownloadFormStore", function() { return __WEBPACK_IMPORTED_MODULE_1__DownloadFormStoreWrapper__["a"]; });



/***/ }),
/* 88 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return GlobalDataStore; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__actioncreators_GlobalActionCreators__ = __webpack_require__(56);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }



var GlobalDataStore = function GlobalDataStore(_GlobalDataStore2) {
  return function (_GlobalDataStore) {
    _inherits(EuPathDBGlobalDataStore, _GlobalDataStore);

    function EuPathDBGlobalDataStore() {
      _classCallCheck(this, EuPathDBGlobalDataStore);

      return _possibleConstructorReturn(this, (EuPathDBGlobalDataStore.__proto__ || Object.getPrototypeOf(EuPathDBGlobalDataStore)).apply(this, arguments));
    }

    _createClass(EuPathDBGlobalDataStore, [{
      key: 'handleAction',
      value: function handleAction(state, _ref) {
        var type = _ref.type,
            payload = _ref.payload;

        switch (type) {
          case __WEBPACK_IMPORTED_MODULE_0__actioncreators_GlobalActionCreators__["c" /* SITE_CONFIG_LOADED */]:
            return Object.assign({}, state, {
              siteConfig: payload.siteConfig
            });

          case __WEBPACK_IMPORTED_MODULE_0__actioncreators_GlobalActionCreators__["a" /* BASKETS_LOADED */]:
            return Object.assign({}, state, {
              basketCounts: payload.basketCounts
            });

          case __WEBPACK_IMPORTED_MODULE_0__actioncreators_GlobalActionCreators__["b" /* QUICK_SEARCH_LOADED */]:
            return Object.assign({}, state, {
              quickSearches: payload.questions,
              quickSearchesLoading: false
            });

          default:
            return state;
        }
      }
    }]);

    return EuPathDBGlobalDataStore;
  }(_GlobalDataStore2);
};

/***/ }),
/* 89 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return DownloadFormStore; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__util_reporter__ = __webpack_require__(57);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }



/** Return subcass of the provided DownloadFormStore */
var DownloadFormStore = function DownloadFormStore(_DownloadFormStore2) {
  return function (_DownloadFormStore) {
    _inherits(EupathDownloadFormStore, _DownloadFormStore);

    function EupathDownloadFormStore() {
      _classCallCheck(this, EupathDownloadFormStore);

      return _possibleConstructorReturn(this, (EupathDownloadFormStore.__proto__ || Object.getPrototypeOf(EupathDownloadFormStore)).apply(this, arguments));
    }

    _createClass(EupathDownloadFormStore, [{
      key: 'getSelectedReporter',
      value: function getSelectedReporter(selectedReporterName, recordClassName) {
        return Object(__WEBPACK_IMPORTED_MODULE_0__util_reporter__["a" /* selectReporterComponent */])(selectedReporterName, recordClassName);
      }
    }]);

    return EupathDownloadFormStore;
  }(_DownloadFormStore2);
};

/***/ }),
/* 90 */
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"./": 14,
	"./ActiveGroup": 41,
	"./ActiveGroup.jsx": 41,
	"./Announcements": 36,
	"./Announcements.jsx": 36,
	"./CookieBanner": 40,
	"./CookieBanner.jsx": 40,
	"./DatasetGraph": 60,
	"./DatasetGraph.jsx": 60,
	"./DateParam": 49,
	"./DateParam.jsx": 49,
	"./DateRangeParam": 50,
	"./DateRangeParam.jsx": 50,
	"./FilterParamNew": 46,
	"./FilterParamNew.jsx": 46,
	"./FlatVocabParam": 47,
	"./FlatVocabParam.jsx": 47,
	"./Footer": 33,
	"./Footer.jsx": 33,
	"./Menu": 39,
	"./Menu.jsx": 39,
	"./NewWindowLink": 34,
	"./NewWindowLink.jsx": 34,
	"./NumberParam": 51,
	"./NumberParam.jsx": 51,
	"./NumberRangeParam": 52,
	"./NumberRangeParam.jsx": 52,
	"./Param": 45,
	"./Param.jsx": 45,
	"./Parameters": 44,
	"./Parameters.jsx": 44,
	"./QuestionWizard": 15,
	"./QuestionWizard.jsx": 15,
	"./QuickSearch": 37,
	"./QuickSearch.jsx": 37,
	"./SiteHeader": 35,
	"./SiteHeader.jsx": 35,
	"./SmallMenu": 38,
	"./SmallMenu.jsx": 38,
	"./SrtHelp": 10,
	"./SrtHelp.jsx": 10,
	"./StringParam": 48,
	"./StringParam.jsx": 48,
	"./index": 14,
	"./index.js": 14,
	"./reporters/ExcelNote": 8,
	"./reporters/ExcelNote.jsx": 8,
	"./reporters/FastaGeneReporterForm": 27,
	"./reporters/FastaGeneReporterForm.jsx": 27,
	"./reporters/FastaGenomicSequenceReporterForm": 28,
	"./reporters/FastaGenomicSequenceReporterForm.jsx": 28,
	"./reporters/FastaOrfReporterForm": 29,
	"./reporters/FastaOrfReporterForm.jsx": 29,
	"./reporters/FastaOrthoSequenceReporterForm": 30,
	"./reporters/FastaOrthoSequenceReporterForm.jsx": 30,
	"./reporters/Gff3ReporterForm": 26,
	"./reporters/Gff3ReporterForm.jsx": 26,
	"./reporters/JsonReporterForm": 25,
	"./reporters/JsonReporterForm.jsx": 25,
	"./reporters/SharedReporterForm": 9,
	"./reporters/SharedReporterForm.jsx": 9,
	"./reporters/TableReporterForm": 12,
	"./reporters/TableReporterForm.jsx": 12,
	"./reporters/TabularReporterForm": 22,
	"./reporters/TabularReporterForm.jsx": 22,
	"./reporters/TextReporterForm": 23,
	"./reporters/TextReporterForm.jsx": 23,
	"./reporters/TranscriptAttributesReporterForm": 32,
	"./reporters/TranscriptAttributesReporterForm.jsx": 32,
	"./reporters/TranscriptTableReporterForm": 31,
	"./reporters/TranscriptTableReporterForm.jsx": 31,
	"./reporters/XmlReporterForm": 24,
	"./reporters/XmlReporterForm.jsx": 24
};
function webpackContext(req) {
	return __webpack_require__(webpackContextResolve(req));
};
function webpackContextResolve(req) {
	var id = map[req];
	if(!(id + 1)) // check for number or string
		throw new Error("Cannot find module '" + req + "'.");
	return id;
};
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = 90;

/***/ }),
/* 91 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = httpGet;
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_jquery__ = __webpack_require__(61);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_jquery___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_0_jquery__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash__ = __webpack_require__(0);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_lodash___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_1_lodash__);



var get = Object(__WEBPACK_IMPORTED_MODULE_1_lodash__["memoize"])(__WEBPACK_IMPORTED_MODULE_0_jquery___default.a.get);
var pendingPromise = {
  then: function then() {}
};

function mapError(xhr) {
  if (xhr.statusText !== 'abort') {
    throw xhr.statusText;
  }
  return pendingPromise;
}

function httpGet(url) {
  var xhr = get(url);
  return {
    promise: function promise() {
      return Promise.resolve(xhr.promise()).then(__WEBPACK_IMPORTED_MODULE_1_lodash__["identity"], mapError);
    },
    abort: function abort() {
      if (xhr.status == null) {
        xhr.abort();
        get.cache.delete(url);
      }
    }
  };
}

/***/ }),
/* 92 */
/***/ (function(module, exports, __webpack_require__) {

var map = {
	"./": 11,
	"./FooterController": 62,
	"./FooterController.jsx": 62,
	"./HeaderController": 63,
	"./HeaderController.jsx": 63,
	"./QuestionWizardController": 64,
	"./QuestionWizardController.jsx": 64,
	"./TreeDataViewerController": 53,
	"./TreeDataViewerController.jsx": 53,
	"./index": 11,
	"./index.js": 11
};
function webpackContext(req) {
	return __webpack_require__(webpackContextResolve(req));
};
function webpackContextResolve(req) {
	var id = map[req];
	if(!(id + 1)) // check for number or string
		throw new Error("Cannot find module '" + req + "'.");
	return id;
};
webpackContext.keys = function webpackContextKeys() {
	return Object.keys(map);
};
webpackContext.resolve = webpackContextResolve;
module.exports = webpackContext;
webpackContext.id = 92;

/***/ }),
/* 93 */
/***/ (function(module, exports) {

module.exports = NaturalSort;

/***/ }),
/* 94 */
/***/ (function(module, exports) {

module.exports = Wdk.PromiseUtils;

/***/ }),
/* 95 */
/***/ (function(module, exports) {

module.exports = Wdk.Stores;

/***/ }),
/* 96 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return wrapRoutes; });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__controllers_TreeDataViewerController__ = __webpack_require__(53);
function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }



/**
 * Wrap WDK Routes
 */
var wrapRoutes = function wrapRoutes(wdkRoutes) {
  return [{ path: '/tree-data-viewer', component: __WEBPACK_IMPORTED_MODULE_0__controllers_TreeDataViewerController__["default"] }].concat(_toConsumableArray(wdkRoutes));
};

/***/ }),
/* 97 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = mainMenuItems;
function mainMenuItems(props, defaultMenuItems) {
  return [defaultMenuItems.home, defaultMenuItems.search, defaultMenuItems.strategies, defaultMenuItems.basket, {
    id: 'tools',
    text: 'Tools',
    children: [{
      id: 'blast',
      text: 'BLAST',
      webAppUrl: '/showQuestion.do?questionFullName=SequenceQuestions.ByBlast'
    }, {
      id: 'assign-to-groups',
      text: 'Assign your proteins to groups',
      webAppUrl: '/proteomeUpload.do'
    }, {
      id: 'download-software',
      text: 'Download OrthoMCL software',
      url: '/common/downloads/software'
    }, {
      id: 'web-services',
      text: 'Web Services',
      webAppUrl: '/serviceList.jsp'
    }, {
      id: 'pubs',
      text: 'Publications mentioning OrthoMCL',
      url: 'http://scholar.google.com/scholar?as_q=&num=10&as_epq=&as_oq=OrthoMCL&as_eq=encrypt+cryptography+hymenoptera&as_occt=any&as_sauthors=&as_publication=&as_ylo=&as_yhi=&as_sdt=1.&as_sdtp=on&as_sdtf=&as_sdts=39&btnG=Search+Scholar&hl=en'
    }]
  }, {
    id: 'data-summary',
    text: 'Data Summary',
    children: [{
      id: 'genome-statistics',
      text: 'Genome Statistics',
      webAppUrl: '/getDataSummary.do?summary=release'
    }, {
      id: 'genome-sources',
      text: 'Genome Sources',
      webAppUrl: '/getDataSummary.do?summary=data'
    }]
  }, {
    id: 'downloads',
    text: 'Downloads',
    url: '/common/downloads'
  }, {
    id: 'community',
    text: 'Community',
    children: [{
      id: 'public-strats',
      text: 'Public Strategies',
      webAppUrl: '/showApplication.do?tab=public_strat'
    }, {
      id: 'twitter',
      text: 'Follow us on Twitter!',
      url: 'https://twitter.com/VEuPathDB',
      target: '_blank'
    }, {
      id: 'facebook',
      text: 'Follow us on Facebook!',
      url: 'https://facebook.com/pages/EuPathDB/133123003429972',
      target: '_blank'
    }, {
      id: 'youtube',
      text: 'Follow us on YouTube!',
      url: 'https://youtube.com/user/EuPathDB/videos?sort=dd&flow=list&view=1',
      target: '_blank'
    }]
  }, defaultMenuItems.favorites];
}

/***/ }),
/* 98 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (immutable) */ __webpack_exports__["a"] = smallMenuItems;
function smallMenuItems(props, defaultMenuItems) {
  return [{
    id: 'about',
    text: 'About OrthoMCL',
    webAppUrl: '/about.do',
    children: [{
      id: 'release',
      text: 'Current Release 6.1',
      webAppUrl: '/about.do#release'
    }, {
      id: 'forming_groups',
      text: 'Method for Forming and Expanding Ortholog Groups',
      webAppUrl: '/about.do#forming_groups'
    }, {
      id: 'orthomcl_algorithm',
      text: 'The OrthoMCL Algorithm',
      webAppUrl: '/about.do#orthomcl_algorithm'
    }, {
      id: 'background',
      text: 'Background on Orthology and Prediction',
      webAppUrl: '/about.do#background'
    }, {
      id: 'faq',
      text: 'Frequently Asked Questions',
      webAppUrl: '/about.do#faq'
    }, {
      id: 'software',
      text: 'Software',
      webAppUrl: '/about.do#software'
    }, {
      id: 'publications',
      text: 'Publications mentioning OrthoMCL',
      url: 'http://scholar.google.com/scholar?as_q=&num=10&as_epq=&as_oq=OrthoMCL+PlasmoDB+ToxoDB+CryptoDB+TrichDB+GiardiaDB+TriTrypDB+AmoebaDB+MicrosporidiaDB+%22FungiDB%22+PiroplasmaDB+ApiDB+EuPathDB&as_eq=encrypt+cryptography+hymenoptera&as_occt=any&as_sauthors=&as_publication=&as_ylo=&as_yhi=&as_sdt=1.&as_sdtp=on&as_sdtf=&as_sdts=39&btnG=Search+Scholar&hl=en'
    }, {
      id: 'acknowledgements',
      text: 'Acknowledgements',
      webAppUrl: '/about.do#acknowledge'
    }, {
      id: 'brochure',
      text: 'EuPathDB Brochure',
      url: 'http://eupathdb.org/tutorials/eupathdbFlyer.pdf'
    }, {
      id: 'usage',
      text: 'Website Usage Statistics',
      url: '/proxystats/awstats.pl?config=orthomcl.org'
    }, {
      id: 'contact',
      text: 'Contact',
      webAppUrl: '/about.do#contact'
    }]
  }, {
    id: 'help',
    text: 'Help',
    children: [{
      id: 'tutorials',
      text: 'Web Tutorials',
      webAppUrl: '/showXmlDataContent.do?name=XmlQuestions.Tutorials'
    }, {
      id: 'workshop',
      text: 'EuPathDB Workshop',
      url: 'http://workshop.eupathdb.org/current/'
    }, {
      id: 'exercises',
      text: 'Exercises from Workshop',
      url: 'http://workshop.eupathdb.org/current/index.php?page=schedule'
    }, {
      id: 'glossary',
      text: 'NCBI\'s Glossary of Terms',
      url: 'http://www.genome.gov/Glossary/'
    }, {
      id: 'contact-us',
      text: 'Contact Us',
      webAppUrl: '/contact.do',
      target: '_blank'
    }]
  }, defaultMenuItems.profileOrLogin, defaultMenuItems.registerOrLogout, defaultMenuItems.contactUs, defaultMenuItems.twitter, defaultMenuItems.facebook, defaultMenuItems.youtube];
}

/***/ })
/******/ ]);
//# sourceMappingURL=site-client.bundle.js.map