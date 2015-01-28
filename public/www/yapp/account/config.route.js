(function() {
    'use strict';

    angular
        .module('yapp.account')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.account", {
            url: "/account",
            views: {
                menuContent: {
                    templateUrl: "yapp/account/account.html",
                    controller: "Account"
                }
            }
        });
    }

})();
