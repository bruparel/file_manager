// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
  'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
    }
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {

    if (($("#send_email").attr('checked')) && ($("#subject").val() == ""))  {
      alert("Subject cannot be blank if you want to send an email");
      return false;
    }

    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery.fn.toggleOpposite = function(readonly)  {
  if (readonly && this.val().length > 0) {
    // reset the value to null
    this.val('');
  }
  return this.attr('disabled',readonly).css('opacity', readonly ? 0.5 : 1.0).focus();
};

//$(document).ready(function() {
//  $("#new_comment").submitWithAjax();
//})
