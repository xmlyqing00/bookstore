$(function() {
	$('.field, textarea').focus(function() {
        if(this.title==this.value) {
            this.value = '';
        }
    }).blur(function(){
        if(this.value=='') {
            this.value = this.title;
        }
    });

    $('#slider ul').jcarousel({
    	scroll: 1,
		auto: 7,
		itemFirstInCallback : mycarousel_firstCallback,
        wrap: 'both'
    });
   function mycarousel_firstCallback(carousel, item, idx) {
        $('#slider .nav a').bind('click', function() {
            carousel.scroll(jQuery.jcarousel.intval($(this).text()));
            $('#slider .nav a').removeClass('active');
            $(this).addClass('active');
            return false;
        });
        $('#slider .nav a').removeClass('active');
        $('#slider .nav a').eq(idx-1).addClass('active');
    }
	
    $('#best-sellers ul').jcarousel({
        auto: 5,
        scroll: 1,
        wrap: 'circular'
    });
	
     if ($.browser.msie && $.browser.version.substr(0,1)<7) {
        DD_belatedPNG.fix('#logo h1 a, .read-more-btn, #slider .image img, #best-sellers .jcarousel-prev, #best-sellers .jcarousel-next, #slider .jcarousel-container, #best-sellers .price, .shell, #footer, .products ul li a:hover');
    }
});


function checkMoreCopies() {
    var itemfield1 = $('input[name=book_name]');
    var itemfield2 = $('input[name=copy]');
    if (itemfield1.val() != "" && itemfield2.val() != "") {
        return true;
    } else {
        alert("Please Enter ALL Items !!");
        return false;
    }
}

function checkNewBook() {
    var itemfield = new Array();
    itemfield[0] = $('input[name=ISBN]');
    itemfield[1] = $('input[name=title]');
    itemfield[2] = $('input[name=author]');
    itemfield[3] = $('input[name=publisher]');
    itemfield[4] = $('input[name=publish_year]');
    itemfield[5] = $('input[name=copies]');
    itemfield[6] = $('input[name=prices]');
    itemfield[7] = $('input[name=copies]');
    itemfield[8] = $('input[name=format]');
    itemfield[9] = $('input[name=keywords]');
    itemfield[10] = $('input[name=subject]');
    for (var i = 0; i < 11 ; i++) {
        if (itemfield[i].val() == "") {
            alert("Please Enter ALL Items !!");
            return false;
        }
    }
    return true;
}