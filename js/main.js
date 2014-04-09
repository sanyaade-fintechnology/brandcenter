function setServiceStatus(service, status){
  $("#"+service).addClass(status["status"]);
  $("#"+service).find('.status-message').html(status["details"])
}

function setMainStatus(overall){
  $("#overall").addClass(overall["status"]);
  $("#overall").find('.message').html(overall["details"])
}

$.ajax({
  url: '/status.json',
  dataType: "json",
  success: function (data) {
    // Set the last update date and time
    statusUpdatedAt = new Date(data["updated_at"]);
    $(".date").html(statusUpdatedAt.toLocaleDateString());
    $(".time").html(statusUpdatedAt.toLocaleTimeString());
    // Process the services status
    services = data["services"];
    for (service in services) {
      if (services.hasOwnProperty(service)){
        setServiceStatus(service, services[service])
      }
    }
    setMainStatus(data["overall"])
  }
});
