

window.addEvent('domready', function() {
	
	var status = {
		'true': '&#169; NAIC 2010',
		'false': '&#169; NAIC 2010'
	};
	
	var searchtext = $('searchtext');
	
	if (searchtext) {
		new OverText(searchtext);
	} else {}
	
	var gobut = $('gobut');
	
	if (gobut) {
		gobut.addEvent('click', function(){
		
			var searchquery = searchtext.getProperty('value');
			var thisURI = new URI();
			thisURI.set('file', 'catalogue.xql');
			thisURI.setData('q', searchquery);
			window.location.href = thisURI;
			
		});
	} else {}

	if (searchtext) {
		searchtext.addEvent('keydown', function(event){
			// the passed event parameter is already an instance of the Event class.
			if (event.key == 'enter') {
				var searchquery = searchtext.getProperty('value');
				var thisURI = new URI();
				thisURI.set('file', 'catalogue.xql');
				thisURI.setData('exact', 'false');
				thisURI.setData('q', searchquery);
				window.location.href = thisURI;
			}
		});
		
		searchtext.addEvent('focus', function(event){
	    // the passed event parameter is already an instance of the Event class.
		searchtext.select();
		});
		
	} else {}
	
	var sortoptions = $('sortoptions');
	if (sortoptions) {
			sortoptions.addEvent('change', function(){
			var order = sortoptions.getProperty('value');

			var thisURI = new URI();
			thisURI.setData('order', order);
		    window.location.href = thisURI;
			});
	}
	
	if (typeof displaydiv != "undefined") {
		var myAccordion = new Fx.Accordion($$('.titleselect'), $$('.blind'), {
		    display: displaydiv,
		    alwaysHide: true,
			onActive: function(toggler, element){
				toggler.setProperty('class','titleselect on');
			},
			onBackground: function(toggler, element){
				toggler.setProperty('class','titleselect');
			}
		});		
	}

	
	//-vertical

	var copyrightVerticalSlide = new Fx.Slide('vertical_slide').hide();

        $('v_toggle').addEvent('click', function(e) {
		
		e.stop();
		copyrightVerticalSlide.toggle();
	});
	
	// When Vertical Slide ends its transition, we check for its status
	// note that complete will not affect 'hide' and 'show' methods
	copyrightVerticalSlide.addEvent('complete', function() {
		$('vertical_status').set('html', status[copyrightVerticalSlide.open]);
	});
	          
		//Google Analytics	  
	  var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-6683479-4']);
      _gaq.push(['_trackPageview']);
        
      (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

});

