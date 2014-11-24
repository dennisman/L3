var TEAM_CHAT_SEND = 1;
var TEAM_CHAT_RECEIVE = 2;
var TEAM_CHAT_MEMBERS = 3;
var TEAM_CHAT_ENABLE = 4;
var MP_RECEIVE = 5;
var NOTIFICATION_RECEIVE = 6;
var FORUM_CHAT_ENABLE = 7;
var FORUM_CHAT_SEND = 8;
var FORUM_CHAT_RECEIVE = 9;
var MP_UNREAD_MESSAGES = 10;
var MP_READ = 11;
var FIGHT_LISTEN = 12;
var FIGHT_GENERATED = 12;
var FIGHT_WAITING_POSITION = 13;

var _pageTitle;
var _socket;
var _socketConnected = false;
var _socketQueue = new Array();
var _socketTentatives = 5;
var _socketTentative = 1;
var _socketDelay = 1000;
var _notifCount = 0;
var _messageCount = 0;
var _needNotifUpdate = false;
var _popup = null;
var _codePreviewI = 1;

var _static = 'http://static.' + location.host;

var _dev = false;
var _log;

_dev = document.URL.indexOf("http://dev.leekwars.com") === 0;
_test = document.URL.indexOf("http://test.leekwars.com") === 0;

var SMILEYS = [
	[":O", ":-O"], [":D", ":-D"], ["&lt;3", "(l)", "(L)"], [":)", ":-)", ":]"], [], [";)", ";-)"], 
	[":("], [":p", ":P", ":-p"], ["(lama)"], [":B", ":b"], ["(lucky)"]
];

$(document).ready(function() {

	_log = (_dev || _test || (typeof(__FARMER_ID) !== 'undefined' && __FARMER_ID === 1)) ? console.log.bind(console) : function() {};

	// Settings actions
	$("#settings-button").click(function(event) {

		$('#settings').toggle();
		if ($('#notifs').is(':visible')) {
			$('#notifs').hide();
		}
		if ($('#messages').is(':visible')) {
			$('#messages').hide();
		}
		event.stopPropagation();
	});
	
	$('#settings').click(function(e) {
		e.stopPropagation();
	});
	$('#notifs').click(function(e) {
		e.stopPropagation();
	});
	$('#messages').click(function(e) {
		e.stopPropagation();
	});
	
	_pageTitle = document.title; // real page title
	
	if (typeof __NOTIF_COUNT !== 'undefined' && __NOTIF_COUNT > 0) {
		_notifCount = __NOTIF_COUNT;
	}
	if (typeof __MESSAGE_COUNT !== 'undefined' && __MESSAGE_COUNT > 0) {
		_messageCount = __MESSAGE_COUNT;
	}
	updateCounters();
	
	$("#messages-button").click(function(event) {
		
		$('#messages').toggle();
		if ($('#settings').is(':visible')) {
			$('#settings').hide();
		}
		if ($('#notifs').is(':visible')) {
			$('#notifs').hide();
		}
		event.stopPropagation();
	});
	
	$("#notifs-button").click(function(event) {
		
		if (_needNotifUpdate) {
			
			$('#notifs-wrapper').html("<br><center><img src='" + _static + "/image/loader.gif'></img></center><br>");
			
			ajax('farmer_update', {id: __FARMER_ID, get_notifs: true}, function(data) {
				$('#notifs-wrapper').html(data);
			});
		}
		
		if (_notifCount > 0) {
			
			ajax('notifications_update', {read: true});
			
			_notifCount = 0;
			updateCounters();
		}

		$('#notifs').toggle();
		if ($('#settings').is(':visible')) {
			$('#settings').hide();
		}
		if ($('#messages').is(':visible')) {
			$('#messages').hide();
		}
		event.stopPropagation();
	});
	
	$("html").click(function() {
		
		if ($('#settings').is(':visible')) {
			$('#settings').hide();
		}
		if ($('#notifs').is(':visible')) {
			$('#notifs').hide();
		}
		if ($('#messages').is(':visible')) {
			$('#messages').hide();
		}
	});
	
	// Menu latéral
	if (!_isTouchScreen()) {
		$(window).scroll(function() {
			
			var scroll = $(window).scrollTop();
			if (scroll < 85) {
				$('#menu').css('position', 'static');
				$('#menu').css('margin-top', '0');
			} else {
				$('#menu').css('position', 'fixed');
				$('#menu').css('margin-top', -85);
			}
		});
	}
	
	// ToolTips
	$('.tooltip').each(function() {
		
		$(this).appendTo('body');
		$(this).append("<div class='arrow'></div>");
		
		var tt = this;
		var id = $(this).attr("id")
		var parent = $("#" + id.substring(3, id.length));
		
		$(parent).mouseenter(function() { 
			
			// Check content
			if ($.trim($(tt).text()) == "") return;
			
			if ($(tt).hasClass('disabled')) return;
			
			$(tt).stop(1,1).fadeIn(100);
			var height = $(this).outerHeight() + ($(this)[0].getBBox ? $(this)[0].getBBox().height : 0);
			if ($(tt).hasClass('top')) { 
				$(tt).css('top', $(this).offset().top - $(tt).outerHeight() - 15);
			} else {
				$(tt).css('top', $(this).offset().top + height + 15);
			}
			var width = $(this).outerWidth() + ($(this)[0].getBBox ? $(this)[0].getBBox().width : 0);
			$(tt).css('left', $(this).offset().left + width / 2);
			$(tt).css('margin-left',  - $(tt).outerWidth() / 2);
		});
		
		$(parent).mouseleave(function() {
			$(tt).stop(1,1).fadeOut(100);
		});
	});
	
	// Debug
	$('#debug-raw').appendTo($('#admin-debug'));
	$('#show-debug').click(function() {
		$('#admin-debug').toggle();
	});
	
	// Keep connected
	if (typeof __FARMER_ID !== 'undefined') {
		setInterval(function() {
			ajax('farmer_update', {id: __FARMER_ID, update: true});
		}, 59 * 1000);
	}
	
	// Logout
	$('#logout-button').click(function() {
		ajax('farmer_update', {id: __FARMER_ID, logout: true}, function(data) {
			_log(data);
			window.location.href = '/';
		});
	});

	resize();
	$(window).resize(resize);
	
	// Websocket
	if (typeof __FARMER_ID !== 'undefined') {
		initSocket();
	}
	
	// Dev
	if (_dev) {
		$('body').addClass('dev');
		$('#logo').parent().append("<span class='dev-label'>dev</span>");
	}
	if (_test) {
		$('body').addClass('test');
		$('#logo').parent().append("<span class='test-label'>test</span>");
	}

	// Échap
	$(document).keyup(function(e) {
		if (e.keyCode == 27) { 
			if (_popup != null) _popup.dismiss();
		} 
	});

	// Popups de report
	$('.report-popup').each(function() {

		var popupView = $(this);
		var popup = new Popup($(this).attr('id'));

		$(this).find('.report-validate').click(function() {

			if (popupView.find("input:radio[name='reason']:checked").length == 0) {
				Toast("Vous devez choisir un motif !");
				return;
			}

			var target = popupView.attr('target');
			var reason = popupView.find("input:radio[name='reason']:checked").attr('id').replace('reason-', '');
			var message = popupView.find('.report-message').val();
			var parameter = popupView.attr('parameter');

			_log('Report farmer ' + target + ' reason : ' + reason + ", message : " + message + ", parameter : " + parameter);
			ajax('warning_update', {report: true, target: target, reason: reason, message: message, parameter: parameter}, function(data) {

				if (data == 1) {
					Toast("Merci pour le signalement");
					popup.dismiss();
				} else {
					Toast(data);
				}
			});
		});
	});

	// Didactitiel
	if ($('#didactitiel').length > 0) {
		didactitiel();
	}

	// Message d'avertissement
	_consoleAlertMessage();
});

function didactitiel() {

	var currentPage = 0;
	var count = $('#didactitiel .content .page').length;
	var didactitiel = new Popup('didactitiel', 800, true);
	didactitiel.setDismissable(false);
	didactitiel.show();

	$('#didactitiel .pagination').text("1 / " + count);

	$('#didactitiel .content .page').hide();
	$('#didactitiel .content .page').first().show();
	$('#didactitiel .content').height($('#didactitiel .content .page').first().height() + 30);

	$('#didactitiel .skip-previous').click(function() {
		if (currentPage == 0) {
			didactitiel.dismiss();
		} else {
			currentPage--;
			if (currentPage == 0) {
				$(this).html("❌&nbsp; Passer");
			}

			$('#didactitiel .next').html("Suivant &nbsp;▶");

			$($('#didactitiel .content .page')[currentPage + 1]).animate({
				left: '820px'
			}, 600);

			$($('#didactitiel .content .page')[currentPage]).show().css('left', '-780px').animate({
				left: '20px'
			}, 600);

			$('#didactitiel .content').animate({
				height: $($('#didactitiel .content .page')[currentPage]).height() + 30
			}, 400);

			$('#didactitiel .pagination').text((currentPage + 1) + " / " + count);
		}
	});

	$('#didactitiel .next').click(function() {
		currentPage++;
		$('#didactitiel .skip-previous').html("◄&nbsp; Précédent");
		if (currentPage >= count - 1) {
			$(this).text("Jouer !");
		}
		if (currentPage >= count) {
			didactitiel.dismiss();
		} else {

			$($('#didactitiel .content .page')[currentPage - 1]).animate({
				left: '-780px'
			}, 600);

			$($('#didactitiel .content .page')[currentPage]).show().css('left', '820px').animate({
				left: '20px'
			}, 600);

			$('#didactitiel .content').animate({
				height: $($('#didactitiel .content .page')[currentPage]).height() + 30
			}, 400);

			$('#didactitiel .pagination').text((currentPage + 1) + " / " + count);
		}
	});
}

function sfw() {

	days = 2;
	var date = new Date();
	date.setTime(date.getTime ()+(days*24*60*60*1000));
	var expires = "; expires="+date.toGMTString();
	document.cookie = 'sfw=true' + expires;

	$('body').addClass('sfw');
	$("#favicon").attr("href", "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9oFFAADATTAuQQAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAAEklEQVQ4y2NgGAWjYBSMAggAAAQQAAGFP6pyAAAAAElFTkSuQmCC");
}

function nsfw() {

	_log("nsfw");
	document.cookie = 'sfw=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';

	$('body').removeClass('sfw');
	$("#favicon").attr("href", _static + "/image/favicon.png");
}
 
function initSocket() {

	var url = "leekwars.com";
	var port = 1213;
	
	if (_dev) {
		url = "dev.leekwars.com";
		port = 80;
	}
	if (_test) {
		url = "test.leekwars.com";
		port = 80;
	}

	if (_socketTentative < 3)
		_socket = new WebSocket('ws://' + url + ':' + port + '/wsTest');
	else
		_socket = new WebSocket('ws://' + url + '/wsTest');
	
	_socketTentative++;
	 
	_socket.onopen = function() { 
		
		_socketConnected = true;
		if (typeof(teamChatEnable) !== 'undefined') teamChatEnable();
		if (typeof(forumChatEnable) !== 'undefined') forumChatEnable();
		if (typeof(adminEnable) !== 'undefined') adminEnable();

		for (var p in _socketQueue) {
			sendDirect(_socketQueue[p]);
		}
		_socketQueue = [];

		// On enlève tous les loaders
		$('.websocket-loader').remove();
	}
	
	_socket.onclose = function() { 
		
		if (_socketTentatives > 0) {
			_socketTentatives--;
			setTimeout(function() {
				initSocket();
			}, _socketDelay);
		}
	}
	
	_socket.onerror = function() { 
		_log('Socket : Une erreur est survenue'); 
	}
	
	_socket.onmessage = function(msg) {
		
		data = JSON.parse(msg.data);
		
		_log("Reçu : ", data);
		
		var id = data[0];
		var data = data[1];

		if (typeof(adminReceive) !== 'undefined') adminReceive(id, data);
		
		switch (id) {
			
			case 0 : {
				send({id: 0});
				break;
			}
			case TEAM_CHAT_MEMBERS : {
				if (typeof(teamChatMembers) !== 'undefined') teamChatMembers(data);
				break;
			}
			case TEAM_CHAT_RECEIVE : {
				if (typeof(teamChatReceive) !== 'undefined') teamChatReceive(data);
				break;
			}
			case FORUM_CHAT_RECEIVE : {
				if (typeof(forumChatReceive) !== 'undefined') forumChatReceive(data);
				break;
			}
			case FIGHT_WAITING_POSITION : {
				if (typeof(fightWaitingPosition) !== 'undefined') fightWaitingPosition(data);
				break;
			}
			case FIGHT_GENERATED : {
				if (typeof(fightGenerated) !== 'undefined') fightGenerated(data);
				break;
			}
			case NOTIFICATION_RECEIVE : {

				_notifCount = data[0];
				updateCounters();
				_needNotifUpdate = true;

				if (_notifCount > 0) {
					var id = 0;

					ajax('notifications_update', {get_layout: id}, function(data) {

						data = JSON.parse(data);

						displaySquare(_static + "/image/notif/" + data.image + ".png", data.title, data.message, data.link, true);
					});
				}
					
				break;
			}
			case MP_RECEIVE : {
				
				var handled = false;
				if (typeof(messageReceive) !== 'undefined') {
					 handled = messageReceive(data);
				}
				
				if (!handled) {
					
					// Ajout dans les notifs
					addMPNotif(data);
					
					if (data[4]) { // Il faut augmenter le compteur
						_messageCount++;
						updateCounters();
					}
					
					// Ajout du carré
					var convID = data[0];
					var farmerID = data[1];
					var farmerName = data[2];
					var message = data[3];
					displaySquare("/avatar-" + farmerID + ".png", farmerName, "► " + message, "/messages/conv=" + convID, false);
				}
				break;
			}
			case MP_UNREAD_MESSAGES : {
				_messageCount = data[0];
				updateCounters();
				break;
			}
		}
	}
}

function updateCounters() {
	
	if (_notifCount + _messageCount > 0) {
		document.title = "(" + (_notifCount + _messageCount) + ") " + _pageTitle;
	} else {
		document.title = _pageTitle;
	}
	
	if (_notifCount > 0) {
		$('#notifs-indicator').text(_notifCount);
		$('#notifs-indicator').show();
	} else {
		$('#notifs-indicator').hide();
	}
	
	if (_messageCount > 0) {
		$('#messages-indicator').text(_messageCount);
		$('#messages-indicator').show();
	} else {
		$('#messages-indicator').hide();
	}
}

function send(request) {
	if (_socketConnected) {
		sendDirect(request);
	} else {
		_socketQueue.push(request);
	}
}

function sendDirect(request) {
	_log("Requête :", request);
	_socket.send(JSON.stringify(request));
}

function resize() {
	setPopups(); 
	setTimeout(setPopups, 500);
}

function setPopups() {
	if ($('#settings-button').length > 0) {
		$('#settings').css('left', $("#settings-button").offset().left + 10 - $('#settings').width() / 2);
		$('#settings').css('top', $("#settings-button").offset().top + 37);
	}
	
	if ($('#messages-button').length > 0) {
		$('#messages').css('left', $("#messages-button").offset().left + 12 - $('#messages').width() / 2);
		$('#messages').css('top', $("#messages-button").offset().top + 39);
	}
	
	if ($('#notifs-button').length > 0) {
		$('#notifs').css('left', $("#notifs-button").offset().left + 10 - $('#notifs').width() / 2);
		$('#notifs').css('top', $("#notifs-button").offset().top + 37);
	}
}

function setTooltipContent(tt, content) {
	tt.html(content);
	tt.append("<div class='arrow'></div>");
	$(tt).css('margin-left',  - $(tt).outerWidth() / 2);
}

function addMPNotif(data) {
	
	var convID = data[0];
	var farmerID = data[1];
	var farmerName = data[2];
	var message = protect(data[3]);
	
	// Recherche d'une conversation existante
	var changed = false;
	$('#messages-menu .pm').each(function() {
		if ($(this).attr('conv') == convID) {
			$(this).removeClass('unseen').addClass('unseen');
			$(this).find('.message').text(message);
			changed = true;
		}
	});
	if (!changed) {
		var mp = "<a href='/messages/conv=" + convID + "'>";
		mp += "<div class='pm' conv='" + convID + "'>";
		mp += "<div class='title'><b>" + farmerName + "</b></div>";
		mp += "<div class='message'>" + message + "</div>";
		mp += "<span class='date'>" + FormatTime(new Date().getTime() / 1000) + "</span>";
		mp += "</div></a>";
		$('#messages-menu').append(mp);
		$('#messages-menu .pm').last().parent().remove();
	}
}

/*
 * Popups
 */
var Popup = function(id, width, direct) {

	this.view = $('#' + id);

	this.height = $(window).height() - 200;

	this.dismissable = true;
	
	if (width != undefined) {
		this.view.css('width', width);
	}

	var actionCount = this.view.find('.actions div').length;
	if (actionCount == 2) {
		this.view.find('.actions div').css('width', '50%');
	}

	this.setDismissable = function(dismissable) {
		this.dismissable = dismissable;
	}
	
	this.show = function(e) {

		if (e == undefined && !direct) {
			alert("Pas d'event passé dans le show()");
			return;
		}
		
		var popup = this;
		_popup = popup;

		$('#popups').show();
		$('#dark').fadeIn(200);
		//~ disableScroll();
		
		this.view.prependTo('#popups td');
		this.view.css('display', 'inline-block');

		popup.view.css("-webkit-transition", "all ease 0.3s");
		popup.view.css("-webkit-transform", "scaleY(0.5)");
		popup.view.css("opacity", "1");
		setTimeout(function() {
			popup.view.css("-webkit-transform", "scaleY(1)");
		});

		var self = this;
		if (this.dismissable) {
			$("html").click(function() {
				self.dismiss();
			});
			
			this.view.click(function(e) {
				e.stopPropagation();
			});
		}
		
		// On regarde si y'a un bouton dismiss
		var cancelButton = this.view.find('.dismiss');
		if (cancelButton.length > 0) {
			cancelButton.click(function() {
				self.dismiss();
			});
		}
		
		if (e) e.stopPropagation();
	}
	
	this.dismiss = function() {
		
		$('#popups').hide();
		$('#dark').fadeOut(200);

		var popup = this;
		popup.view.css("-webkit-transition", "all ease 0.2s");
		popup.view.css("-webkit-transform", "scaleY(1)");
		setTimeout(function() {
			popup.view.css("-webkit-transform", "scaleY(0)");
			popup.view.css("opacity", "0");
		});
		setTimeout(function() {
			popup.view.hide();
		});

		_popup = null;
		
		//~ enableScroll();
	}
}

/*
 * For disabling scrolling
 */

// left: 37, up: 38, right: 39, down: 40,
// spacebar: 32, pageup: 33, pagedown: 34, end: 35, home: 36
var keys = [37, 38, 39, 40];

function preventDefault(e) {
  e = e || window.event;
  if (e.preventDefault)
      e.preventDefault();
  e.returnValue = false;  
}

function keydown(e) {
    for (var i = keys.length; i--;) {
        if (e.keyCode === keys[i]) {
            preventDefault(e);
            return;
        }
    }
}

function wheel(e) {
  preventDefault(e);
}

function disableScroll() {
  if (window.addEventListener) {
      window.addEventListener('DOMMouseScroll', wheel, false);
  }
  window.onmousewheel = document.onmousewheel = wheel;
  document.onkeydown = keydown;
}

function enableScroll() {
    if (window.removeEventListener) {
        window.removeEventListener('DOMMouseScroll', wheel, false);
    }
    window.onmousewheel = document.onmousewheel = document.onkeydown = null;  
}

/*
 * Requetes ajax simplifiées 
 */
function ajax(page, data, done) {
	
	var struct = {type: "POST", url: "/index.php?page=" + page};
	
	var token = (typeof(__TOKEN) !== 'undefined') ? __TOKEN : "";

	if (data == null) {
		data = {};
	}
	struct.data = data;
	if (data instanceof FormData) {
		data.append('token', token);
		struct.cache = false;
		struct.processData = false;
		struct.contentType = false;
	} else if (typeof(data) === 'string') {
		struct.data = data + "&token=" + token;
	} else {
		data.token = token;
	}
	$.ajax(struct).done(function(data) {
		_log(data);
		if (done) done(data);
	});
}

/*
 * Toasts
 */
var Toast = function(text, durationOrCallBack) {
		
	_log(text);
	
	var d = 1800;
	var callback = null;
	
	if (typeof durationOrCallBack == "number") {
		d = durationOrCallBack;
	} else if (typeof durationOrCallBack == "function") {
		callback = durationOrCallBack;
	}
	
	$('#toasts').append("<span class='toast'>" + text + "</span>");
	
	var toast = $('.toast').last();
	
	toast.hide().fadeIn(300).delay(d).fadeOut(500, function() {
		toast.remove();
		if (callback != null) callback();
	});
}

var Reload = function() {
	window.location.reload();
}

var CheckUploadImage = function(file) {
	
	if (!file) {
		Toast('Aucun fichier sélectionné...');
		return false;
	}

	var types = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/bmp'];

	if (types.indexOf(file.type) == -1) {
		Toast("Type de fichier (" + file.type + ") non accepté...");
		return false;
	}
	
	if (file.size > 10485760) {
		Toast("Fichier trop volumineux, maximum 10 Méga octets...");
		return false;
	}
	
	return true;
}

var ImageFileToImage = function(file, imageElem) {
	
	if (window.FileReader) {
			
		reader = new FileReader();
		reader.onloadend = function(e) { 
			$(imageElem).attr('src', e.target.result);
		};
		reader.readAsDataURL(file);
	}
}

var FormatTime = function(time) {
	
	var hours = Math.floor(time / 3600);
	var minuts = Math.floor((time % 3600) / 60);
	var seconds = time - hours * 3600 - minuts * 60;
	
	var res = "";
	if (hours > 0) res += hours + "h ";
	if (minuts > 0) res += minuts + "m ";
	res += seconds + "s";
	
	return res;
}

// Prépare les websockets
if (window.MozWebSocket) {
	window.WebSocket = window.MozWebSocket;
}

function smiley(data) {
	
	for (var s in SMILEYS) {
		for (var i in SMILEYS[s]) {
			var x = -1 - s * 18;
			data = data.split(SMILEYS[s][i]).join("<span class='smiley' title='" + SMILEYS[s][i] + "' style=\"background-position: " + x + "px -1px;\"></span>");
		}
	}
	return data;
}

function smileyElem(elem) {
	
	$(elem).html(smiley($(elem).html()));
	
	// Remove smiley in code tags
	$('pre .smiley').each(function() {
		$(this).replaceWith($(this).attr('title'));
	});
}

function protect(string) {
	return string.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
}

function chatAddMessage(chat, author, authorName, msg, time, grade, avatarChanged) {
	
	var message = protect(msg);
	message = message.replace(/&amp;/g, "&amp;<null/>");
	message = message.replace(/&gt;/g, "&gt;<span></span>");
	message = message.replace(/&lt;/g, "&lt;<span></span>");
	message = message.replace(/&quot;/g, "&quot;<span></span>");
	
	message = smiley(message);
	message = linkify(message);
	message = commands(message, authorName);
	
	var date = new Date(time * 1000);
	var minuts = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
	var timeStr = date.getHours() + ":" + minuts;
	
	// Dernier message envoyé par la meme personne, y'a moins de 2 minutes ?
	var last = $(chat).find(".chat-message").last();
	
	if (last.attr('author') == author && time - parseInt(last.attr('time')) < 120) {
		
		// On ajoute direct dans le message précédent
		last.find('.chat-message-messages').append("<div>" + message + "</div>");
		
	} else {
	
		var gradeClass = grade > 1 ? ["moderator", "admin"][grade - 2] : ""; 

		var avatar = avatarChanged > 0 ? _static + '/image/avatar/' + author + ".png" : _static + "/image/no_avatar.png";

		var messageData = "<div class='chat-message' author='" + author + "' time='" + time + "'>";
		messageData += "<a href='/farmer/" + author + "'><img class='chat-avatar' src='" + avatar + "'></img></a>";
		messageData += "<a href='/farmer/" + author + "'><div class='chat-message-author " + gradeClass + "'>" + authorName + "</div></a>";
		messageData += "<div class='chat-message-time'>" + timeStr + "</div>";
		messageData += "<div class='chat-message-messages'><div>" + message + "</div></div>";
		messageData += "</div>";
		
		$(chat).append(messageData);
	}
	
	if ($(chat)[0].scrollHeight - $(chat).scrollTop() - $(chat).height() < 100) {
		$(chat).scrollTop($(chat)[0].scrollHeight);
	}
}

function createCodeTags(elem) {
	
	data = $(elem).html();
	
	// On enlève les retours à la ligne après une balise code, y'a déjà un br naturel
	data = data.replace(/\[\/code\]<br>/g, "[/code]");
	
	var OP_SIZE = "[code]".length;
	var CL_SIZE = "[/code]".length;
	
	var pos = 0;
	var length = data.length;
	
	// Balise [code] ouvrante
	while ((pos = data.indexOf("[code]", pos)) != -1) {
		
		var next = data.indexOf("[code]", pos + "[code]".length);
		
		// On cherche la fermante...
		var closing = data.indexOf('[/code]');
			
		// C'est bon ?
		if (closing != -1 && (next == -1 || next > closing)) {
			
			var code = $.trim(data.substring(pos + OP_SIZE, closing).replace(/<br>\s\n/g, "\n").replace(/<br>/g, "\n"));
			
			data = data.substring(0, pos) + "<textarea class='forum-code'>" + code + "</textarea>" + data.substring(closing + CL_SIZE);
			
		} else {
			break; // Erreur de balise
		}
	}
	
	$(elem).html(data);
			
	$('textarea.forum-code:not(.ok)').each(function() {
		
		var preview = "code-preview-" + _codePreviewI++;
		$("<pre id='" + preview + "'></pre>").insertAfter(this);

		_createCodeArea($(this).val(), document.getElementById(preview));

		$(this).remove();
	});
}

function _createCodeArea(code, element) {

	CodeMirror.runMode(code, "leekscript", element);
	
	var pre = $(element);
	
	for (var i = 0; i < pre.length; i++) {
		pre[i].innerHTML = '<span class="line-number"></span>' + pre[i].innerHTML + '<span class="cl"></span>';
		var num = pre[i].innerHTML.split(/\n/).length;
		for (var j = 0; j < num; j++) {
			var line_num = pre[i].getElementsByTagName('span')[0];
			line_num.innerHTML += '<span>' + (j + 1) + '</span>';
		}
	}
}

function _spaceThousands(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "&nbsp;")
}

function createHabs(habs) {
	return _spaceThousands(habs) + "&nbsp;<span class='hab'></span>";
}
function createCrystals(crystals) {
	return _spaceThousands(crystals) + "&nbsp;<span class='crystal'></span>";
}

function linkify(text) {

	// http://, https://, ftp://
	// var urlPattern = /\b(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^\s()<>]|\/)))/gim;
	var urlPattern = /(\b([\w-]+:\/\/?|www[.])[-A-Z0-9+&@#\/%?=~_|!:,.;()]*[-A-Z0-9+&@#\/%=~_|])/gim;

	// Email addresses
	var emailAddressPattern = /\w+@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6})+/gim;
	
	var blank = function (url) {
		return (url.indexOf("http://www.leekwars.com") != 0
		 && url.indexOf("http://leekwars.com") != 0
		 && url.indexOf("www.leekwars.com") != 0
		 && url.indexOf("leekwars.com") != 0) ? "target='_blank' rel='nofollow'" : "";
	};

	return text
		.replace(urlPattern, function(url) { 
			var http = url.indexOf('http') != 0 ? 'http://' : '';
			return '<a ' + blank(url) + ' href="' + http + url + '">' + url + '</a>' 
		})
		.replace(emailAddressPattern, '<a target="_blank" rel="nofollow" href="mailto:$&">$&</a>');
}

function linkifyElem(elem) {
	
	$(elem).html(linkify($(elem).html()));
}

function commands(text, authorName) {
	
	text = text.replace(/(^| )\/me($| )/g, "$1<i>" + authorName + "</i>$2");
	
	return text;
}

function displaySquare(image, title, message, link, padding) {
	
	message = protect(message)
	message = smiley(message);
	message = linkify(message);
	
	var square = "<a href='" + link + "'>";
	square += "<div class='square'>";
	square += "<img class='image " + (padding ? "padding" : "") + "' src='" + image + "'></img>";
	square += "<div class='title'>" + title + "</div>";
	square += "<div class='message'>" + message + "</div>";
	square += "</div></a>";
	
	$('#squares').append(square); 
	
	// Animation
	$("#squares .square").last().css('margin-bottom', -$("#squares .square").last().outerHeight());
	$("#squares .square").last().animate({
		marginBottom: 20,
		}, 500, function() {
			$("#squares .square").last().css('margin-bottom', 20);
		}
	);
	$("#squares .square").last().delay(5000).animate({
		marginRight: -220,
		}, 500, function() {
			$(this).remove();
		}
	);
}

function _consoleAlertMessage() {
	var style = "color: black; font-size: 13px; font-weight: bold;";
	var styleRed = "color: red; font-size: 14px; font-weight: bold;";
	console.log("%c Attention ! Si quelqu'un vous demande d'entrez un programme ici,", style);
	console.log("%c il s'agit d'une tentative de piratage de votre compte sur Leek Wars.", styleRed);
	console.log("%c Entrez du code ici seulement si vous savez exactement ce que vous faites.", style);
	console.log("");
}

function _isTouchScreen() {
	
	if (navigator.userAgent.match(/Android/i)
		|| navigator.userAgent.match(/webOS/i)
		|| navigator.userAgent.match(/iPhone/i)
		|| navigator.userAgent.match(/iPad/i)
		|| navigator.userAgent.match(/iPod/i)
		|| navigator.userAgent.match(/BlackBerry/i)
		|| navigator.userAgent.match(/Windows Phone/i)
	) {
		return true;
	} else {
		return false;
	}
}

function submitForm(page, params) {
	var form = $('<form>', {
		'method': 'post',
        'action': '/' + page
    });
	for (var p in params) {
		form.append($('<input>', {
	        'name': params[p][0],
	        'value': params[p][1],
	        'type': 'hidden'
	    }));
	}
	form.append($('<input>', {'name': 'token', 'value': __TOKEN, 'type': 'hidden'}));
	$("body").append(form);
    form.submit();
}

function _inLocalStorage(key) {
	try {
    	return (key in localStorage);
  	} catch (e) {
  		return false;
  	}
}

function _getLocalStorage(key) {
	try {
    	return localStorage[key];
  	} catch (e) {
  		return null;
  	}
}

function _setLocalStorage(key, value) {
	try {
    	localStorage[key] = value;
  	} catch (e) {}
}