(function () {
    
    angular
        .module("yapp")
		.run(runFunction);

    runFunction.$inject = ['$ionicPlatform', '$q', 'DSCacheFactory'];
    function runFunction($ionicPlatform, $q, DSCacheFactory) {

        $ionicPlatform.ready(function() {
						setTimeout(function() {
							$cordovaSplashScreen.hide()
						}, 5000);
					
            // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
            // for form inputs)
            if (window.cordova && window.cordova.plugins.Keyboard) {
                cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
            }
            if (window.StatusBar) {
                // org.apache.cordova.statusbar required
                StatusBar.styleDefault();
            }

            // caches for services
            if (DSCacheFactory.get('localCache') == null) {
                DSCacheFactory('localCache', {storageMode: 'localStorage', maxAge: 5000, deleteOnExpire: 'aggressive'});
            }
            if (DSCacheFactory.get('staticCache') == null) {
                DSCacheFactory('staticCache', {storageMode: 'localStorage'});
            }
        });
    }  

})();