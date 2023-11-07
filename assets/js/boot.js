/**
 *  Use aysnc script loader, configure the application module (for AngularJS)
 *  and initialize the application ( which configures routing )
 *
 *  @author Thomas Burleson
 */

(function (head) {
    "use strict";

    head.js(
        // Pre-load these for splash-screen progress bar...

        { require:      "./vendor/requirejs/require.js"                             },

        { jquery:       "./vendor/jquery/dist/jquery.js"                            },

        { angular:      "./vendor/angular/angular.js"                               },
        { uiRouter:     "./vendor/angular-ui-router/release/angular-ui-router.js"   },
        { uiBootstrap:  "./vendor/angular-bootstrap/ui-bootstrap-tpls.js"           },
        { ngSanitize:   "./vendor/angular-sanitize/angular-sanitize.js"             },
        { ngResource:   "./vendor/angular-resource/angular-resource.js"             },
        { ngCookies:    "./vendor/angular-cookies/angular-cookies.js"               },

        { bootstrap:    "./vendor/bootstrap/dist/js/bootstrap.js"                   },
        { ngSlider:     "./vendor/angular-slider/slider.js"                         },
        { duScroll:    "./vendor/angular-scroll/angular-scroll.js"                   },

        { radiotape:       "./assets/js/radiotape.js"                               }


    )
        .ready("ALL", function () {

            require.config(
                {
                    //urlArgs: "bust=" + (new Date()).getTime(),
                    appDir: '',
                    baseUrl: './js'

                });

            require([ "main" ], function (app) {
                // Application has bootstrapped and started...
            });


        });

}(window.head));