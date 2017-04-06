
	//* detect touch devices 
    function is_touch_device() {
	  return !!('ontouchstart' in window);
	}
	$(document).ready(function() {
		//* search typeahead
		$('.search_query').typeahead({
			source: ["Lima","Arequipa","Lambayeque","Huancayo"],
			items: 4
		});
		//* accordion change actions
		$('#side_accordion').on('hidden shown', function () {
			cgr_sidebar.make_active();
            cgr_sidebar.update_scroll();
		});
		//* resize elements on window resize
		var lastWindowHeight = $(window).height();
		var lastWindowWidth = $(window).width();
		$(window).on("debouncedresize",function() {
			if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){
				lastWindowHeight = $(window).height();
				lastWindowWidth = $(window).width();
				cgr_sidebar.update_scroll();
				if(!is_touch_device()){
                    $('.sidebar_switch').qtip('hide');
                }
			}
		});
		//* tooltips
		cgr_tips.init();
        if(!is_touch_device()){
		    //* popovers
            cgr_popOver.init();
        }
		//* sidebar
        cgr_sidebar.init();
		cgr_sidebar.make_active();
		//* breadcrumbs
        cgr_crumbs.init();
		//* pre block prettify
		if(typeof prettyPrint == 'function') {
			prettyPrint();
		}
		//* external links
		cgr_external_links.init();
		//* accordion icons
		cgr_acc_icons.init();
		//* colorbox single
		cgr_colorbox_single.init();
		//* main menu mouseover
		cgr_nav_mouseover.init();
		//* top submenu
		cgr_submenu.init();
		
		cgr_sidebar.make_scroll();
		cgr_sidebar.update_scroll();
		
		//* style switcher
		cgr_style_sw.init();
	});
    
    cgr_sidebar = {
        init: function() {
			// sidebar onload state
			if($(window).width() > 979){
                if(!$('body').hasClass('sidebar_hidden')) {
                    if( $.cookie('cgr_sidebar') == "hidden") {
                        $('body').addClass('sidebar_hidden');
                        $('.sidebar_switch').toggleClass('on_switch off_switch').attr('title','Mostrar Sidebar');
                    }
                } else {
                    $('.sidebar_switch').toggleClass('on_switch off_switch').attr('title','Mostrar Sidebar');
                }
            } else {
                $('body').addClass('sidebar_hidden');
                $('.sidebar_switch').removeClass('on_switch').addClass('off_switch');
            }

			cgr_sidebar.info_box();
			//* sidebar visibility switch
            $('.sidebar_switch').click(function(){
                $('.sidebar_switch').removeClass('on_switch off_switch');
                if( $('body').hasClass('sidebar_hidden') ) {
                    $.cookie('cgr_sidebar', null);
                    $('body').removeClass('sidebar_hidden');
                    $('.sidebar_switch').addClass('on_switch').show();
                    $('.sidebar_switch').attr( 'title', "Ocultar Sidebar" );
                } else {
                    $.cookie('cgr_sidebar', 'hidden');
                    $('body').addClass('sidebar_hidden');
                    $('.sidebar_switch').addClass('off_switch');
                    $('.sidebar_switch').attr( 'title', "Mostrar Sidebar" );
                }
				cgr_sidebar.info_box();
				cgr_sidebar.update_scroll();
				$(window).resize();
            });
			//* prevent accordion link click
            $('.sidebar .accordion-toggle').click(function(e){e.preventDefault()});
        },
		info_box: function(){
			var s_box = $('.sidebar_info');
			var s_box_height = s_box.actual('height');
			s_box.css({
				'height'        : s_box_height
			});
			$('.push').height(s_box_height);
			$('.sidebar_inner').css({
				'margin-bottom' : '-'+s_box_height+'px',
				'min-height'    : '100%'
			});
        },
		make_active: function() {
			var thisAccordion = $('#side_accordion');
			thisAccordion.find('.accordion-heading').removeClass('sdb_h_active');
			var thisHeading = thisAccordion.find('.accordion-body.in').prev('.accordion-heading');
			if(thisHeading.length) {
				thisHeading.addClass('sdb_h_active');
			}
		},
        make_scroll: function() {
            antiScroll = $('.antiScroll').antiscroll().data('antiscroll');
        },
        update_scroll: function() {
			if($('.antiScroll').length) {
				if( $(window).width() > 979 ){
					$('.antiscroll-inner,.antiscroll-content').height($(window).height() - 40);
				} else {
					$('.antiscroll-inner,.antiscroll-content').height('400px');
				}
				antiScroll.refresh();
			}
        }
    };

	//* tooltips
	cgr_tips = {
		init: function() {
			if(!is_touch_device()){
				var shared = {
				style		: {
						classes: 'ui-tooltip-shadow ui-tooltip-tipsy'
					},
					show		: {
						delay: 100,
						event: 'mouseenter focus'
					},
					hide		: { delay: 0 }
				};
				if($('.ttip_b').length) {
					$('.ttip_b').qtip( $.extend({}, shared, {
						position	: {
							my		: 'top center',
							at		: 'bottom center',
							viewport: $(window)
						}
					}));
				}
				if($('.ttip_t').length) {
					$('.ttip_t').qtip( $.extend({}, shared, {
						position: {
							my		: 'bottom center',
							at		: 'top center',
							viewport: $(window)
						}
					}));
				}
				if($('.ttip_l').length) {
					$('.ttip_l').qtip( $.extend({}, shared, {
						position: {
							my		: 'right center',
							at		: 'left center',
							viewport: $(window)
						}
					}));
				}
				if($('.ttip_r').length) {
					$('.ttip_r').qtip( $.extend({}, shared, {
						position: {
							my		: 'left center',
							at		: 'right center',
							viewport: $(window)
						}
					}));
				};
			}
		}
	};
    
    //* popovers
    cgr_popOver = {
        init: function() {
            $(".pop_over").popover();
        }
    };
    
    //* breadcrumbs
    cgr_crumbs = {
        init: function() {
            if($('#jCrumbs').length) {
				$('#jCrumbs').jBreadCrumb({
					endElementsToLeaveOpen: 0,
					beginingElementsToLeaveOpen: 0,
					timeExpansionAnimation: 500,
					timeCompressionAnimation: 500,
					timeInitialCollapse: 500,
					previewWidth: 30
				});
			}
        }
    };
	
	//* external links
	cgr_external_links = {
		init: function() {
			$("a[href^='http']").not('.thumbnail>a,.ext_disabled').each(function() {
				$(this).attr('target','_blank').addClass('external_link');
			})
		}
	};
	
	//* accordion icons
	cgr_acc_icons = {
		init: function() {
			var accordions = $('.main_content .accordion');
			
			accordions.find('.accordion-group').each(function(){
				var acc_active = $(this).find('.accordion-body').filter('.in');
				acc_active.prev('.accordion-heading').find('.accordion-toggle').addClass('acc-in');
			});
			accordions.on('show', function(option) {
				$(this).find('.accordion-toggle').removeClass('acc-in');
				$(option.target).prev('.accordion-heading').find('.accordion-toggle').addClass('acc-in');
			});
			accordions.on('hide', function(option) {
				$(option.target).prev('.accordion-heading').find('.accordion-toggle').removeClass('acc-in');
			});	
		}
	};
	
	//* main menu mouseover
	cgr_nav_mouseover = {
		init: function() {
			$('header li.dropdown').mouseenter(function() {
				if($('body').hasClass('menu_hover')) {
					$(this).addClass('navHover')
				}
			}).mouseleave(function() {
				if($('body').hasClass('menu_hover')) {
					$(this).removeClass('navHover open')
				}
			});
		}
	};
    
	//* single image colorbox
	cgr_colorbox_single = {
		init: function() {
			if($('.cbox_single').length) {
				$('.cbox_single').colorbox({
					maxWidth	: '80%',
					maxHeight	: '80%',
					opacity		: '0.2', 
					fixed		: true
				});
			}
		}
	};
	
	//* submenu
	cgr_submenu = {
		init: function() {
			$('.dropdown-menu li').each(function(){
				var $this = $(this);
				if($this.children('ul').length) {
					$this.addClass('sub-dropdown');
					$this.children('ul').addClass('sub-menu');
				}
			});
			
			$('.sub-dropdown').on('mouseenter',function(){
				$(this).addClass('active').children('ul').addClass('sub-open');
			}).on('mouseleave', function() {
				$(this).removeClass('active').children('ul').removeClass('sub-open');
			})
			
		}
	};
	
	//* style switcher
	cgr_style_sw = {
		init: function() {
			$('body').append('<a class="ssw_trigger" href="javascript:void(0)"><i class="icon-cog icon-white"></i></a>');
			var defLink = $('#link_theme').clone();
			
			
			$('input[name=ssw_sidebar]:first,input[name=ssw_layout]:first,input[name=ssw_menu]:first').attr('checked', true);
			
			$(".ssw_trigger").click(function(){
				$(".style_switcher").toggle("fast");
				$(this).toggleClass("active");
				return false;
			});
			
			// colors
			$('.style_switcher .jQclr').click(function() {
                $(this).closest('div').find('.style_item').removeClass('style_active');
				$(this).addClass('style_active');
				var style_selected = $(this).attr('title');
				$('#link_theme').attr('href','css/'+style_selected+'.css');
            });
			
			// backgrounds
			$('.style_switcher .jQptrn').click(function(){
				$(this).closest('div').find('.style_item').removeClass('style_active');
				$(this).addClass('style_active');
				var style_selected = $(this).attr('title');
				if($(this).hasClass('jQptrn')) { $('body').removeClass('ptrn_a ptrn_b ptrn_c ptrn_d ptrn_e').addClass(style_selected); };
			});
			//* layout
			$('input[name=ssw_layout]').click(function(){
				var layout_selected = $(this).val();
				$('body').removeClass('cgr-fixed').addClass(layout_selected);
			});
			//* sidebar position
			$('input[name=ssw_sidebar]').click(function(){
				var sidebar_position = $(this).val();
				$('body').removeClass('sidebar_right').addClass(sidebar_position);
				$(window).resize();
			});
			//* menu show
			$('input[name=ssw_menu]').click(function(){
				var menu_show = $(this).val();
				$('body').removeClass('menu_hover').addClass(menu_show);
			});
			
			//* reset
			$('#resetDefault').click(function(){
				$('body').attr('class', '');
				$('.style_item').removeClass('style_active').filter(':first-child').addClass('style_active');
				$('#link_theme').replaceWith(defLink);
				$('.ssw_trigger').removeClass('active');
				$(".style_switcher").hide();
				return false;
			});
			
			
		}
	};