$.ajax({
      url: 'status.json',
      dataType: "json",
      success: function (data) {
        statusUpdatedAt = new Date(data["updated_at"])
        console.log(statusUpdatedAt)
      }
});
