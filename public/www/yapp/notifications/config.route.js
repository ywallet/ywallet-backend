(function() {
    'use strict';

    angular
        .module('yapp.notifications')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.notifications", {
            url: "/notifications",
            views: {
                menuContent: {
                    templateUrl: "yapp/notifications/notifications.html",
                    controller: "Notifications"
                }
            }
        });
    }

})();
