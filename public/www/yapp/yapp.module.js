(function () {
    'use strict';

    angular.module('yapp', [
        /*
         * Order is not important. Angular makes a
         * pass to register all of the modules listed
         * and then when app.dashboard tries to use app.data,
         * it's components are available.
         */
        'ionic',
        'angular-data.DSCacheFactory',
        'ngCordova',
        'ng-token-auth',

        /*
         * Everybody has access to these.
         * We could place these under every feature area,
         * but this is easier to maintain.
         */
        'pascalprecht.translate',
        'yapp.services',

        /*
         * Feature areas
         */
        'yapp.layout',
        'yapp.authentication',
        'yapp.allowances',        
        'yapp.dashboard',
        'yapp.history',
        'yapp.notifications',
        'yapp.payments',
        'yapp.savings',
        'yapp.rules',
        'yapp.settings',
        'yapp.account'
    ]);
})();