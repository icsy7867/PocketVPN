(function() { // Self Executing Function - Keeps Variable Scope Contained to this page
    $(document).ready(function() { // Wait until the document is ready.
        /**
         * UI Stuff (Displaying and Showing Reject Form / Action Buttons)
         */

         //Listen for Create button cick, show/hide button and form
         $("#disconnect-link").click(function(e) {
            //Hide accept button again to discourage double clicking
            $(".disconnect-loading-spinner").show(300);

         });
    });
})();

