(function() {
    'use strict';

    angular
        .module('yapp.allowances')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.allowances", {
            url: "/allowances",
            views: {
                menuContent: {
                    templateUrl: "yapp/allowances/allowances.html",
                    controller: "Allowances"
                }
            }
        });
    }

})();
