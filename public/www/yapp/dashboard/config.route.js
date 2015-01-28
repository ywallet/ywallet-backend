(function() {
    'use strict';

    angular
        .module('yapp.dashboard')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider"];
            
    function defineRoutes($stateProvider) {
        $stateProvider.state("yapp.dashboard", {
            url: "/dashboard",
            views: {
                menuContent: {
                    templateUrl: "yapp/dashboard/dashboard.html",
                    controller: "Dashboard"
                }
            }
        });
    }

})();
