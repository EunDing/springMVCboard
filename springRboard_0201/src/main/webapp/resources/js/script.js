$(document).ready(function(){
    
    $('.menu a').on('click',function(e){
      //  e.preventDefault();
       var index = $(this).parent().index();
    //     $('.menu a').removeClass();
        $('.menu li').eq(index).children('a').addClass('active');

    /*    if(index == 0){ 
            $('.img2').remove();
           $('.item2').remove();
            $('.typho').remove(); 
            
        $('#my_image').attr("src","images/introduce.PNG");
        $('#my_image').css("width","1200px");
        $('.item').css("height","600px");   
           
        } 
        
        if(index == 1){ 
            $('.img2').remove();
            $('.item2').remove();
            $('.typho').remove(); 
            $('#container').css("visibility", "visible");
            $('.imgchange').append($('#container'))
            
        } 
       
        
        if(index == 2){
            $('.img2').remove();
           $('.item2').remove();
            $('.typho').remove(); 
            $('#my_image').attr("src","images/bedroom.PNG");
             $('#my_image').css("width","1200px");
            $('.item').css("height","600px");   

        }
        
        else if(index == 3){
             $('.img2').remove();
           $('.item2').remove();
            $('.typho').remove(); 
            $('#my_image').attr("src","images/map.PNG");
             $('#my_image').css("width","1200px");
        $('.item').css("height","750px");   
    
        }*/
        
    });
});


