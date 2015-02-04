(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSAllowances', DSAllowances);

	DSAllowances.$inject = ['$http', '$q', '$ionicLoading', 'DSCacheFactory'];
	function DSAllowances($http, $q, $ionicLoading, DSCacheFactory)
	{
		var cacheKey = 'Allowances';
		var hostname = (!window.cordova) ? 'api/' : '/android_asset/www/api/';

		var service = {
			getCacheKey : getCacheKey,
			addAllowance: addAllowance,
			rmAllowance: rmAllowance,
			getAllowances: getAllowances
		}

		return service;

		function getCacheKey() {
			return cacheKey;
		}

		function getAllowances(loadCache) {

			var deferred = $q.defer(),
				allowancesCache = DSCacheFactory.get('localCache'),
				allowances = allowancesCache.get(cacheKey);

			if( loadCache === undefined )
				var loadCache = false;

			if( allowances )
				deferred.resolve(allowances);
			else
			{
				if( !loadCache )
					$ionicLoading.show({ template: 'Loading...'});

				$http.get(hostname + 'allowances.json')
					.success(function(data, status){
						allowancesCache.put(cacheKey, data);
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
		
		function addAllowance(qty, period) {
			var deferred = $q.defer();
			deferred.resolve(10);

			return deferred.promise;
		}

		function rmAllowance(id) {

		}
	}

})()