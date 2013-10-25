function setServiceStatus(service, status){
  $("#"+service).addClass(status);
}

$.ajax({
      url: 'status.json',
      dataType: "json",
      success: function (data) {
        statusUpdatedAt = new Date(data["updated_at"]);
        services = data["services"];
        for (service in services) {
          if (services.hasOwnProperty(service)){
            setServiceStatus(service, services[service])
          }
        }
      }
});
