(function () {
    
    angular
        .module("yapp.authentication")
		.run(runFunction);

    runFunction.$inject = ["$rootScope", "$auth", "StateRouter", "DSUser"];

    function runFunction($rootScope, $auth, StateRouter, DSUser) {
        var yUser = DSUser.getUser();

        $rootScope.$on("auth:validation-success", function() {
            console.log("VALIDATION SUCCESS", arguments);
        });
        $rootScope.$on("auth:login-success", function() {
            console.log("LOGIN SUCCESS", arguments);
        });
        $rootScope.$on("auth:login-error", function() {
            console.log("LOGIN ERROR", arguments);
        });
        $rootScope.$on("auth:registration-email-success", function() {
            console.log("REGISTRATION SUCCESS", arguments);
        });
        $rootScope.$on("auth:registration-email-error", function() {
            console.log("REGISTRATION ERROR", arguments);
        });

        $rootScope.$on("auth:validation-error", backToHome);
        $rootScope.$on("auth:invalid", backToHomeAndRemove);
        $rootScope.$on("auth:session-expired", backToHomeAndRemove);
        $rootScope.$on("auth:logout-success", backToHomeAndRemove);
        $rootScope.$on("auth:logout-error", backToHomeAndRemove);

        if (yUser != null) console.log("USER LOADED");
        else               console.log("NO USER");

        DSUser.auth = $auth.validateUser();

        ////////////////////


        function backToHome() {
            console.log("back home", arguments);
            StateRouter.goAndForget("home");
        }

        function backToHomeAndRemove() {
            console.log("invalid session", arguments);
            DSUser.auth = null;
            DSUser.rmUser();
            StateRouter.goAndForget("home");
        }
    }
})();