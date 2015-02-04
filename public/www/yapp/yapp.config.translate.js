(function () {    
    angular
        .module("yapp")
		.config(configAngularTranslate);

	configAngularTranslate.$inject = ["$translateProvider"];

	function configAngularTranslate($translateProvider) {
		$translateProvider.translations('en', translations_en);
		$translateProvider.translations('pt', translations_pt);
		$translateProvider.translations('es', translations_es);
		$translateProvider.translations('fr', translations_fr);
		$translateProvider.translations('it', translations_it);
		$translateProvider.preferredLanguage('en');
		// console.log("$translateProvider initialized");
	}
})();