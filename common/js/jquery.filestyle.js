/*
 * Style File - jQuery plugin for styling file input elements
 *  
 * Copyright (c) 2007-2009 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Based on work by Shaun Inman
 *   http://www.shauninman.com/archive/2007/09/10/styling_file_inputs_with_css_and_the_dom
 *
 */

(function($) {
    
    $.fn.filestyle = function(options) {
                
        /* TODO: This should not override CSS. */
        var settings = {
        	disabled : false
        };
                
        if(options) {
            $.extend(settings, options);
        };
                        
        return this.each(function() {
            
            var self = this;
            var wrapper = $("<div>")
                            .css({
                                "width": settings.imagewidth + "px",
                                "height": settings.imageheight + "px",
                                "background": "url(" + settings.image + ") 0 0 no-repeat",
                                //"background-position": "right",
                                "display": "inline",
                                "float" : "left" ,
                                "position" : "relative",
                                "overflow": "hidden",
                                "margin-right":"8px"
                            });
							
            var value = "";
            if($(self).attr('tmpVal') != undefined)	value = $(self).attr('tmpVal');
            if($(self).css('width') != undefined)	settings.width = $(self).css('width');
            	
            var filename = $('<input class="file" type="text" value="'+value+'">')
                             .addClass($(self).attr("class"))
                             .css({
                                 "display": "inline",
                                 "width": settings.width,
								 "margin-right" : "5px",
								 "float" : "left"
                             });
            
            if(settings.disabled) {
            	filename.attr('disabled', true);
            }
		
			$(self).before(filename);
            $(self).wrap(wrapper);
            $(self).attr('size', settings.imageheight);
            $(self).css({
                        "position": "relative",
                        "height": settings.imageheight + "px",
                        "width": settings.imagewidth + "px",
                        "display": "inline",
                        "cursor": "pointer",
                        "opacity": "0.0",
                        "margin-right":"8px",
                        "margin-left" : settings.imagewidth - settings.width + "px"
                    });

            $(self).bind("change", function() {
                filename.val($(self).val());
            });
      
        });
        

    };
    
})(jQuery);
