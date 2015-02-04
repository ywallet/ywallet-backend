(function() {
    'use strict';

    angular
        .module('yapp.payments')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.payments", {
            url: "/payments",
            views: {
                menuContent: {
                    templateUrl: "yapp/payments/payments.html",
                    controller: "Payments"
                }
            }
        });
    }

})();
