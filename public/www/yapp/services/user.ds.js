(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSUser', DSUser);

	DSUser.$inject = ['$rootScope', 'DSCacheFactory'];

	function DSUser($rootScope, DSCacheFactory) {
		var cacheKey = 'User';

		var service = {
			putUser: putUser,
			rmUser: rmUser,
			getUser: getUser
		}

		return service;


        ////////////////////


		function getCacheKey() {
			return cacheKey;
		}


		function getUser() {
			var user = DSCacheFactory.get('staticCache').get(cacheKey);
            if ($rootScope.yUser == null) {
                $rootScope.yUser = user;
            }
            return user;
		}


		function putUser(user) {
			var userCache = DSCacheFactory.get('staticCache');

			userCache.put(cacheKey, user);
			$rootScope.yUser = user;
		}


		function rmUser() {
			var userCache = DSCacheFactory.get('staticCache');

			userCache.remove(cacheKey);
            $rootScope.yUser = null;
		}
	}

})()