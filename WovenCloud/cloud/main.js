Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.job("WeaveResponseTimeoutSkip", function(request, status) {
  

  Parse.Cloud.useMasterKey();
  var query = new Parse.Query("Weave");

  var d = new Date();
  var time = (12 * 24 * 3600 * 1000);
  var expirationDate = new Date(d.getTime() - (time));

  query.lessThan("updatedAt", expirationDate); 
  query.each(function(weave) {
	if (weave.get("Next").length != 0) {
	  var next = weave.get("Next");
	  var answered = weave.get("Answered");
	  answered.push(next.shift());
	  weave.set("Next", next);
	  weave.set("Answered", answered);
      }
      return weave.save()
  }).then(function() {
    // Set the job's success status
    status.success("Updating pending/overtime weaves to next user successful.");
  }, function(error) {
    // Set the job's error status
    status.error("Something went wrong in updating overtimed weaves.");
  });
});
