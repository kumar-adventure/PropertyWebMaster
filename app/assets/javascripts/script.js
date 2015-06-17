function update_request(element, property_id, property_title){
  jQuery("#property_ids").val( jQuery("#property_ids").val() + "," + property_id )
  jQuery("#selected_properties").append("<div class='span2 property_title'>" + property_title + "</div>"); 
  jQuery(element).attr("disabled", true); 
}
function update_search_type(element, is_sale){
  jQuery("#buy-block").css("background-color", "blue");
  jQuery("#rent-block").css("background-color", "green");
  jQuery(element).css("background-color", "gold");
}


function update_invitee_list(){
  $(this).parent().remove();
}
temp_result = null; 
jQuery(document).ready(function(){

  $(".mini-slides").slidesjs({
    play: {auto: false, interval: 9000, swap: true, pauseOnHover: true},
    height: 65,
    width: 100
  });

  $(".Listing").on("click", function(){
    $(".Listing").css("background","white");
    $(this).css("background", "gold")
    $("#listing_type").val($(this).attr("id") );
  }) 
  $(".Propertytype").on("click", function(){
    $(".Propertytype").css("background","white");
    $(this).css("background", "gold")
    $("#property_type").val($(this).attr("id") );
  })

    
  $("#extruderRight").buildMbExtruder({
    position:"right",
    width:300,
    extruderOpacity:.8,
    textOrientation:"tb",
    onExtOpen:function(){

      $(".remove-prop").on('click', function(){
        $.ajax({
          url: "/properties/"+ $(this).attr("data-id") + "/remove_temp_invitee",
          type: "POST", 
          data: {},
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}, 
          success: function(){
          }
      
        });
        $(this).parent().remove(); 
      });

      if( $("#property_visit_status").val() == false ){ 
        $("#property_visit_status").val(true)
        $("#invitee_list").append("<div class='prop-title'><div class='remove-prop'>X</div>" + $("#property_title").val() + "</div>" );
        $.ajax({
          url: "/properties/"+ $("#property_id").val() + "/add_temp_invitee",
          type: "POST", 
          data: {},
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}, 
          success: function(){
          }
      
        });
      }
    },
    onExtContentLoad:function(){},
    onExtClose:function(){}
  });
})
