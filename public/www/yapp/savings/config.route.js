(function() {
    'use strict';

    angular
        .module('yapp.savings')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.savings", {
            url: "/savings",
            views: {
                menuContent: {
                    templateUrl: "yapp/savings/savings.html",
                    controller: "Savings"
                }
            }
        });
    }

})();
