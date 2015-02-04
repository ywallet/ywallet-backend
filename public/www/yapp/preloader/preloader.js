(function() {
	'use strict';

    angular
		.module('yapp')
		.controller('Preloader', Preloader)

    Preloader.$inject = ["StateRouter", "DSCacheFactory", "DSUser", "DSNotifications", "DSavings"];

	function Preloader(StateRouter, DSCacheFactory, DSUser, DSNotifications, DSavings) {
        var promise = DSUser.auth;

        if (promise != null) {
            console.log("PROMISE");
            DSUser.auth = null;
            promise.then(onSuccess, onFailure);
        } else {
            console.log("NO PROMISE");
            onFailure();
        }

        ////////////////////

        function onSuccess() {
            var yUser = DSUser.getUser();
            if (yUser == null) {
                // not supposed to happen
                console.error("Valid auth but no user.");
            } else {
                preloadData();
            }
        }

        function onFailure(resp) {
            console.log("no authentication", resp);
            StateRouter.goAndForget("authentication.index");
        }


        function preloadData() {
            DSNotifications.getNotifications(); //$rootScope.notifications = []; $rootScope.numNewNotifications = 0;
            DSUser.updateUser(function (data) {
                console.log("User updated", data);
                StateRouter.goAndForget("yapp.dashboard");
            }, function () {
                console.error("Could not update user info.");
                StateRouter.goAndForget("yapp.dashboard");
            });
        }




        /*function todo() {
            // Caches - Define Offline mode
            var localCache = DSCacheFactory.get('localCache');
            localCache.setOptions({
                onExpire: function(key, value) {
                    var check_connection = undefined;

                    switch(key) {
                        case DSavings.getCacheKey() : check_connection = DSavings.getSavings(true); break;
                    }

                    check_connection
                        .then(function() {

                        }, function() {
                            localCache.put(key, value);
                        });
                }
            });
        }*/
	}
})();