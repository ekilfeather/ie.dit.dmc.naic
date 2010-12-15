

window.addEvent('domready', function() {
	
	var status = {
		'true': '&#169; NAIC 2010',
		'false': '&#169; NAIC 2010'
	};
	
	var searchtext = $('searchtext');
	new OverText(searchtext);
	var gobut = $('gobut');
	
	gobut.addEvent('click', function(){
		
			var searchquery = searchtext.getProperty('value');
			var thisURI = new URI();
			thisURI.clearData();
			thisURI.set('file', 'catalogue.xql');
			thisURI.setData('q', searchquery);
		    window.location.href = thisURI;
			
	});

	searchtext.addEvent('keydown', function(event){
	    // the passed event parameter is already an instance of the Event class.
	    if (event.key == 'enter') {
			var searchquery = searchtext.getProperty('value');
			var thisURI = new URI();
			thisURI.clearData();
			thisURI.set('file', 'catalogue.xql');
			thisURI.setData('q', searchquery);
		    window.location.href = thisURI;
		}
	});
	
	searchtext.addEvent('focus', function(event){
	    // the passed event parameter is already an instance of the Event class.
		searchtext.select();
	});

	
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

});

