package com.cellrebel.flutter_cellrebel_sdk;

import android.content.Context;

import com.cellrebel.sdk.workers.TrackingManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterCellrebelSdkPlugin
 */
public class FlutterCellrebelSdkPlugin implements FlutterPlugin, MethodCallHandler {
	/// The MethodChannel that will the communication between Flutter and native Android
	///
	/// This local reference serves to register the plugin with the Flutter Engine and unregister it
	/// when the Flutter Engine is detached from the Activity
	private MethodChannel channel;
	private Context context;

	@Override
	public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
		channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_cellrebel_sdk");
		channel.setMethodCallHandler(this);
		context = flutterPluginBinding.getApplicationContext();
	}

	@Override
	public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
		if (call.method.equals("getPlatformVersion")) {
			result.success("Android " + android.os.Build.VERSION.RELEASE);
		} else if (call.method.equals("init")) {
			final String clientId = call.argument("clientId");
			TrackingManager.init(context, clientId);
		} else if (call.method.equals("startTracking")) {
			TrackingManager.startTracking(context);
		} else if (call.method.equals("stopTracking")) {
			TrackingManager.stopTracking(context);
		} else {
			result.notImplemented();
		}
	}

	@Override
	public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
		channel.setMethodCallHandler(null);
	}
}
