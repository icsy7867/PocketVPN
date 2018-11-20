(function() { // Self Executing Function - Keeps Variable Scope Contained to this page
    $(document).ready(function() { // Wait until the document is ready.
        /**
         * UI Stuff (Displaying and Showing Reject Form / Action Buttons)
         */

         //Listen for Create button cick, show/hide button and form
         $("#form-submit").click(function(e) {
            //Hide accept button again to discourage double clicking
            $(".connect-loading-spinner").show(300);

         });
    });
})();

