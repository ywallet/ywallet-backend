(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSRules', DSRules);

	DSRules.$inject = ['$http', '$q', '$ionicLoading', 'DSCacheFactory'];
	function DSRules($http, $q, $ionicLoading, DSCacheFactory)
	{
		var cacheKey = 'Rules';
		var hostname = (!window.cordova) ? 'api/' : '/android_asset/www/api/';

		var service = {
			getCacheKey : getCacheKey,
			addRule: addRule,
			rmRule: rmRule,
			getRules: getRules
		}

		return service;

		function getCacheKey() {
			return cacheKey;
		}

		function getRules(loadCache) {

			var deferred = $q.defer(),
				rulesCache = DSCacheFactory.get('localCache'),
				rules = rulesCache.get(cacheKey);

			if( loadCache === undefined )
				var loadCache = false;

			if( rules )
				deferred.resolve(rules);
			else
			{
				if( !loadCache )
					$ionicLoading.show({ template: 'Loading...'});

				$http.get(hostname + 'rules.json')
					.success(function(data, status){
						rulesCache.put(cacheKey, data);
						deferred.resolve(data);

						if( !loadCache )
							$ionicLoading.hide();
					})
					.error(function(data, status){
						deferred.reject();

						if( !loadCache )
							$ionicLoading.hide();
					});
			}

			return deferred.promise;
		}
		
		function addRule(qty, period, active) {
			var deferred = $q.defer();
			deferred.resolve(10);

			return deferred.promise;
		}

		function rmRule(id) {

		}
	}

})()