(function() {
    'use strict';

    angular
        .module('yapp.history')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.history", {
            url: "/history",
            views: {
                menuContent: {
                    templateUrl: "yapp/history/history.html",
                    controller: "History"
                }
            }
        });
    }

})();
