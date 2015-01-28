(function() {
	'use strict';

    angular
		.module('yapp')
		.controller('Preloader', Preloader)

    Preloader.$inject = ["$rootScope", "StateRouter", "DSCacheFactory", "DSUser", "DSNotifications", "DSavings"];

	function Preloader($rootScope, StateRouter, DSCacheFactory, DSUser, DSNotifications, DSavings) {
        $rootScope.yUser = null;

        detectSession();

        ////////////////////

        function detectSession() {
            DSUser.getUser();

            if ($rootScope.yUser != null) {
                StateRouter.goAndForget("yapp.dashboard");
            } else {
                StateRouter.goAndForget("authentication.index");
            }
        }


        function preloadData() {
            // Caches - Define Offline mode
            var localCache = DSCacheFactory.get('localCache');
            localCache.setOptions({
                onExpire: function(key, value) {
                    /*var check_connection = undefined;

                    switch(key) {
                        case DSavings.getCacheKey() : check_connection = DSavings.getSavings(true); break;
                    }

                    check_connection
                        .then(function() {

                        }, function() {
                            localCache.put(key, value);
                        });*/
                }
            });
            DSNotifications.getNotifications(); //$rootScope.notifications = []; $rootScope.numNewNotifications = 0;
        }
	}
})();