function setServiceStatus(service, status){
  $("#"+service).addClass(status["status"]);
  $("#"+service).find('.status-message').html(status["details"])
}

$.ajax({
  url: 'status.json',
  dataType: "json",
  success: function (data) {
    statusUpdatedAt = new Date(data["updated_at"]);
    $(".date").html(statusUpdatedAt.toLocaleDateString())
    $(".time").html(statusUpdatedAt.toLocaleTimeString())
    services = data["services"];
    for (service in services) {
      if (services.hasOwnProperty(service)){
        setServiceStatus(service, services[service])
      }
    }
  }
});
