// testing against document since already in scope and
// obfuscation tool will reduce to a single char var
if (!('__proto__' in document)) {

	// inject jQuery into any unsupported browser
	var src = document.location.protocol;
	if (src.indexOf('http')) {
		// note Cordova loads as 'file:'
		src = 'http:';
	}
	src += '//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js';

	try {
		// attempt synchronous inline to maintain script order
		document.write('\u003cscript src="'+src+'">\u003c/script>');

	} catch (ex) {
		// allow asynchronous lazy loading as fallback
		var first = document.getElementsByTagName('script')[0],
			parent = (first && first.parentNode) || document.body,
			elem = document.createElement('script');

		elem.type = 'text/javascript';
		elem.src = src;
		parent.insertBefore(elem, first || parent.firstChild);
	}

	// shortcut loading of Zepto module
	return;
}

// Zepto is officially supported, continue executing rest of module
