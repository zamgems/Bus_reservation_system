
$( document ).on('turbolinks:load', function() { 
 $(".close").on('click', function(){
    $(".alert").slideUp();
  })
 var pre_date = $('#reservation_date').val();
 $("#reservation_date").on("change", function(){
  var d = new Date();

	var month = d.getMonth()+1;
	var day = d.getDate();

	var output = d.getFullYear() + '-' + (month<10 ? '0' : '') + month + '-' + (day<10 ? '0' : '') + day;
	
	var date = this.value;
   	if(date<output){
      alert("past dates");
    }
   	var total_seats =$("#reservation_no_of_seats").attr("max")
   	var customer_id = $('.frm').data('customer_id');
   	var bus_id = $("input:last").val(); 
  	var params = {
       date: date,
       total_seats: total_seats,
       bus_id: bus_id
     };
    
    return $.ajax({
     method: "GET",
     url: '/reservations/show_seats',
     type: "script",
     data: params,
     success: function(){
     	//alert('Saved Successfully');
     },
     error: function(){
     	//alert('error error error');
     },
     complete: function(){

     }
   });
 })
})

