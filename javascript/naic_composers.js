

window.addEvent('domready', function() {
	

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


	var status = {
		'true': '&#169; NAIC 2010',
		'false': '&#169; NAIC 2010'
	};
	
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

