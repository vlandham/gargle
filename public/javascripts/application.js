// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function showMarker(marker, content)
// Show a marker and open it's info window
{
	Effect.ScrollTo('map');
    google_map.closeInfoWindow(); // else get problems
    eval(marker + ".openInfoWindowHtml(\'"+content+"\');");
    //eval("GEvent.trigger(" + marker[0] + ", click)");
}

function hide_notice()
{
	if ($('flash_notice') != null) {
		Effect.Shake('flash_notice');
		Effect.Fade.delay(2, 'flash_notice');
	}
	if ($('flash_alert') != null) {
		Effect.Shake('flash_alert');
		Effect.Fade.delay(2, 'flash_alert');
	}
	if ($('flash_warning') != null) {
		Effect.Shake('flash_warning');
		Effect.Fade.delay(2, 'flash_warning');
	}
}

window.onload=hide_notice;

