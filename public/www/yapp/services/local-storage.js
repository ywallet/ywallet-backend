(function() {
	"use strict";

	angular
		.module("yapp.services")
		.factory("$localStorage", LocalStorage);

	LocalStorage.$inject = ["$window"];

	function LocalStorage($window) {
        return {
            set:        set,
            get:        get,
            setObject:  setObject,
            getObject:  getObject
        };

        ////////////////////

        function set(key, value) {
            $window.localStorage[key] = value;
        }

        function get(key, defaultValue) {
            return $window.localStorage[key] || defaultValue;
        }

        function setObject(key, value) {
            $window.localStorage[key] = JSON.stringify(value);
        }

        function getObject(key) {
            return JSON.parse($window.localStorage[key] || "null");
        }
	}
})();