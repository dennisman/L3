var DEFAULT_FONT_SIZE = 16;
var DEFAULT_THEME = "leek-wars";

var _BASIC = _isTouchScreen();

var current;
var editors = new Array();

var _testEvent;
var _testPopup;
var lastKey = -1;
var lastNewAI = -1;
var editedAI = -1;
var editedIAName;
var _saving = false;

// Paramètres
var _large = false;
var _autoClosing = true;
var _fontSize = DEFAULT_FONT_SIZE;
var _theme = DEFAULT_THEME;
var _autocomplete = true;
var _popups = true;

// Settings de test
var _testPopup = null;
var _testLeek = null;
var _testMode = 'solo';
var _testAI = null;
var _testEnemies = null;

$(document).ready(function() {
	
	// Create editors
	var first = null;

	for (var i in __AI_IDS) {

		var id = __AI_IDS[i];
		var name = __AI_NAMES[i];
		var valid = __AI_VALID[i];
		var level = __AI_LEVELS[i];
		var cores = __AI_CORES[i];
		
		editors[id] = new Editor(id, name, valid, level, cores, "");

		if (first == null) first = id;
	}
	
	// New button
	$('#new-button').click(function() {
		
		submitForm("editor_update", [ ["create", "true"] ] );
	});
	
	// IA de départ
	if (editors.length == 0) {

		$('#loader').hide();
		current = null;

	} else if (typeof __AI_ID !== 'undefined') {
	
		_log("Open id " + __AI_ID);
		
		for (var i in editors) {
			if (editors[i].id == __AI_ID) {
				current = i;
				editors[i].show();
			}
		}
		
	} else if (_getLocalStorage("lastCode")) {
		
		var ok = false;
		
		for (var i in editors) {
			if (editors[i].id == _getLocalStorage("lastCode")) {
				current = i;
				editors[i].show();
				ok = true;
			}
		}
		
		if (!ok && editors.length > 0) {
			current = $('#ai-list .ai').first().attr('id');
			editors[current].show();
		}
		
	} else {
			
		_log(first);
		current = first;
		editors[current].show();
	}
	
	// IA name
	$('#ai-name').click(function() {
		editedAI = current;
	});
	
	$('#ai-name').keyup(function(e) {
		editedIAName = $(this).text();
	});
		
	$('#ai-name').keydown(function(e) {

		if (editedAI == null) return;

		if (e.keyCode == 13) {
			editors[editedAI].updateName(editedIAName);
			editors[editedAI].save();
			
			e.preventDefault();
			$(this).blur();
		}
	});
	$('#ai-name').focusout(function() {

		if (editedAI == null) return;

		editors[editedAI].updateName(editedIAName);
		editors[editedAI].save();
	});
	
	// Boutons
	$("#save-button").click(function() {
		if (current != null)
			editors[current].save();
	});
	
	// Delete popup
	var deletePopup = new Popup('delete-popup', 500);
	
	$("#delete-button").click(function(e) {
		
		if (current != null) {
			deletePopup.show(e);
			$('#deleted-ia').html(editors[current].name);
		}
	});
	
	$('#delete').click(function() {

		if (current != null)
			submitForm('editor_update', [ ["remove", true], ["id", editors[current].id] ]);
	});
	
	
	if (!_isTouchScreen()) {
		$(window).scroll(function() {
			var scroll = $(window).scrollTop();
			if (scroll < 95) {
				$('#editor-left').css('position', 'absolute'); 
				$('#editor-left').css('top', '0');  
				$('#editor-left').css('margin-top', '0');
			} else {
				$('#editor-left').css('position', 'fixed'); 
				$('#editor-left').css('top', 'auto'); 
				$('#editor-left').css('margin-top', -95);    
			}
		});
	}
	
	$(window).resize(editorResize);
	editorResize();
	 
	// Confirmation à la fermeture du tab
	window.onbeforeunload = function(e) {
		var num = 0;
		for (var i in editors) {
			if (editors[i].modified) {
				num++;
			}
		}
		if (num > 0) {
			return 'Vous avez ' + num + ' IA(s) non sauvegardée(s).';
		}
	};

	$(document).keydown(function(e) {

		if (current == null) return;

		// _log("keyCode : " + e.keyCode);
		// _log(e.ctrlKey);

		// Ctrl-Q" : test
		if (e.ctrlKey && e.keyCode == 81) {
			_testEvent = e;
			editors[current].test();
			e.preventDefault();
		}

		// Ctrl-S" : save
		if (e.ctrlKey && e.keyCode == 83) {
			editors[current].save();
			e.preventDefault();
		}

		// Ctrl-Space : autocompletion
		if (e.ctrlKey && e.keyCode == 32) {
			editors[current].autocomplete(true);
			e.preventDefault();
		}

		// Ctrl-Shift-F : format code
		if (e.shiftKey && e.ctrlKey && e.keyCode == 70) {
			editors[current].formatCode();
			e.preventDefault();
		}
	});


	$(window).mousemove(function(e) {
		if (current != null)
			editors[current].mousemove(e);
	});

	var infoPopup = new Popup("info-popup", 500);
	$('#info-button').click(function(e) {
		infoPopup.show(e);
	})

	// Chargement des paramètres
	_large = _getLocalStorage('large') == 'true';
	_autoClosing = _inLocalStorage('editor_auto_closing') ? _getLocalStorage('editor_auto_closing') == 'true' : true;
	_autocomplete = _inLocalStorage('editor_autocomplete') ? _getLocalStorage('editor_autocomplete') == 'true' : true;
	_popups = _inLocalStorage('editor_popups') ? _getLocalStorage('popups') == 'true' : true;
	
	_fontSize = parseInt(_getLocalStorage('editor_font_size'));
	if (isNaN(_fontSize)) _fontSize = DEFAULT_FONT_SIZE;
	$('.CodeMirror').css('font-size', _fontSize);
	
	_theme = _getLocalStorage('editor_theme');
	$('body').addClass(_theme);


	// Popup des paramètres
	var settingsPopup = new Popup('editor-settings-popup', 600);

	$('#editor-settings-button').click(function(e) {
		settingsPopup.show(e);
	});

	$('#setting-size').prop('checked', _large);
	$('#setting-size').change(function() {
		_large = $('#setting-size').is(':checked');
		_setLocalStorage('large', _large);
		_editorResize();
	});

	$('#setting-auto-closing').prop('checked', _autoClosing);
	$('#setting-auto-closing').change(function() {
		_autoClosing = $('#setting-auto-closing').is(':checked');
		_setLocalStorage('editor_auto_closing', _autoClosing);
	});

	$('#setting-autocomplete').prop('checked', _autocomplete);
	$('#setting-autocomplete').change(function() {
		_autocomplete = $('#setting-autocomplete').is(':checked');
		_setLocalStorage('editor_autocomplete', _autocomplete);
	});

	$('#setting-popups').prop('checked', _popups);
	$('#setting-popups').change(function() {
		_popups = $('#setting-popups').is(':checked');
		_setLocalStorage('editor_popups', _popups);
	});

	$('#setting-font-size').val(_fontSize);
	$('#setting-font-size').change(function() {
		var fontSize = parseInt($('#setting-font-size').val());
		_log("Font size : " + fontSize);
		if (!isNaN(fontSize) && _fontSize >= 6 && _fontSize <= 30) {
			_fontSize = fontSize;
			_setLocalStorage('editor_font_size', _fontSize);
			$('.CodeMirror').css('font-size', _fontSize);
		}
	});

	$('#settings-theme #' + _theme).prop('checked', true);
	$('#settings-theme input').click(function() {
		$('body').removeClass(_theme);
		_theme = $(this).val();
		_setLocalStorage('editor_theme', _theme);
		$('body').addClass(_theme);
	});

	_editorResize();


	// Paramètres de test
	_testAI = parseInt(_getLocalStorage('editor_test_ai'));
	if (!(_testAI in editors)) _testAI = _firstKey(editors);

	_testType = _getLocalStorage('editor_test_type');
	if (['solo', 'farmer', 'team'].indexOf(_testType) == -1) _testType = 'solo';

	_testLeek = _getLocalStorage('editor_test_leek');
	if (isNaN(_testLeek)) _testLeek = $('#test-popup .myleek').first().attr('id');

	_testEnemies = _inLocalStorage('editor_test_enemies') ? JSON.parse(_getLocalStorage('editor_test_enemies')) : {'leek1': 2};

	// Popup de test
	_testPopup = new Popup('test-popup', 900);

	$('#test-popup .enemy select').click(function(e) {
		e.stopPropagation();
	});
	
	$('#test-popup .enemy').click(function(e) {
		
		if ($(this).hasClass('selected') && $('#test-popup .enemy.selected').length > 1) {
			$(this).removeClass('selected');
			$(this).find('input[type=checkbox]').prop('checked', false);
			delete _testEnemies['leek' + ($(this).index() + 1)];
		} else {
			$(this).addClass('selected');
			$(this).find('input[type=checkbox]').prop('checked', true);
			_testEnemies['leek' + ($(this).index() + 1)] = $(this).find('select')[0].selectedIndex;
		}
		_saveTestSettings();
	});

	$('#test-popup .enemy select').change(function() {
		var enemy = $(this).closest('.leek').index();
		_testEnemies['leek' + (enemy + 1)] = this.selectedIndex;
		_saveTestSettings();
	})

	$("input:radio[name='test-type']").change(function() {
		_testType = $(this).attr('val');
		_saveTestSettings();
	});
	
	$('#test-popup .myleek').click(function(e) {
		
		$('#test-popup .myleek').removeClass('selected');
		$(this).addClass('selected');

		_testLeek = $(this).attr('id');
		_saveTestSettings();
	});

	$('#test-ais').change(function() {
		_testAI = this[this.selectedIndex].id;
		_saveTestSettings();
	});
	
	// Bouton tester
	$("#launch").click(function() {
		
		var data = {test: true};

		for (var e in _testEnemies) {
			data[e] = _testEnemies[e];
		}

		data.id = _testAI;
		data.myleek = _testLeek;
		data['test-type'] = _testType;
		
		ajax('editor_update', data, function(data) {
			if (!isNaN(parseInt(data))) {
				window.location.href = '/fight/' + data;
			} else {
				Toast("Erreur : " + data);
			}
		});
	});

	$("#test-button").click(function(e) {
		if (current != null) {
			_testEvent = e;
			editors[current].test();
		}
	});
	$('#cancel-test').click(function() {
		_testPopup.dismiss();
	});

	// Ajout des IA dans la liste de test
	$('#test-ais option[id=' + _testAI + ']').attr('selected', 'selected');

	$("input[name='test-type'][val='" + _testType + "']").prop('checked', true);
	
	$("#test-popup .myleek[id='" + _testLeek + "']").addClass('selected');

	for (var e in _testEnemies) {
		var enemy = $('#test-popup .enemy')[parseInt(e.substring(4)) - 1];

		$(enemy).addClass('selected');
		$(enemy).find('input[type=checkbox]').prop('checked', true);
		$(enemy).find("select option[value='value" + _testEnemies[e] + "']").attr('selected', 'selected');
	}
});

function _saveTestSettings() {

	_setLocalStorage('editor_test_type', _testType);
	_setLocalStorage('editor_test_leek', _testLeek);
	_setLocalStorage('editor_test_ai', _testAI);
	_setLocalStorage('editor_test_enemies', JSON.stringify(_testEnemies));
}

function _editorResize() {
	if (_large) enlarge(); else shrink();
}

function enlarge() {
	$('#wrapper').css('max-width', '100%');
	$('.CodeMirror').css('max-width', $(window).width() - 450);
	$('.editor textarea').css('max-width', $(window).width() - 470);
	$('.editor textarea').css('width', $(window).width() - 470);

	_large = true;
	_setLocalStorage('large', true);
	resize();
}

function shrink() {
	$('#wrapper').css('max-width', '1000px');
	$('.CodeMirror').css('max-width', '810px');
	$('.editor textarea').css('max-width', '800px');
	$('.editor textarea').css('width', '800px');

	_large = false;
	_setLocalStorage('large', false);
	resize();
}

function editorResize() {
	$('#ai-list').css('max-height', $(window).height() - 340);
	$('#page').css('min-height', Math.max(600, $('#editor-left').height() + 35));
}

function onCursorChange(editor) {
	editors[current].cursorChange();
}

function onEditorChange(editor, changes) {
	editors[current].change(changes);
}

String.prototype.insert = function( idx, s ) {
    return (this.slice(0,idx) + s + this.slice(idx));
};

function _firstKey(array) {
    for (var k in array) return k;
}