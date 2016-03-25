$(document).ready(function() {

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $("button.create-bucket").click(function(){
    $("div.new-bucket").toggle();
  });


  // Intercepts POST requests in dashboard/index and send a PUT request instead
  $('input.btn_submit').on('click', function(ev){
    // This prevents the form from being submitted, which is de default action
    ev.preventDefault();
    var formdata = $(this).closest('.item-form').serialize();
     // Now we get the form data and put it on a variable
    var formmethod = $(this).attr("name");
    var action_path = $(this).prop("value");
    // Then we sent a PUT request containing the form data
    ajaxRequest(formdata, formmethod, action_path);
  })

  var ajaxRequest = function(formdata, method, action_path) {
    $.ajax(`/items/${action_path}`, {method: method, data: formdata})
    .done(function(result){
      //When the request is done we redirect the user back to the tunes page
      //window.location.href = "/dashboard";
    });
  }


  // $("button.delete-bucket-btn").click(function(){
  //   $("div.delete-bucket").toggle();
  // });

  
  // Intercepts POST requests in dashboard/index and send a PUT request instead
  $('input.delete-bucket-btn').on('click', function(ev){
    // This prevents the form from being submitted, which is de default action
    ev.preventDefault();
    var formdata = $(this).parent().serialize();
     // Now we get the form data and put it on a variable

    // Then we sent a PUT request containing the form data
    console.log(formdata)

    $.ajax(`/buckets/delete`, {method: 'DELETE', data: formdata})
    .done(function(result){
      //When the request is done we redirect the user back to the tunes page
      window.location.href = "/dashboard";
    });
  })











  $('.btn_submit').on("click",
      function(){
          $(this).css("background", "red");

      });
});


