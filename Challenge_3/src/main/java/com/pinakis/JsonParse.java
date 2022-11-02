package com.pinakis;

import java.util.Iterator;
import org.json.JSONObject;

public class JsonParse {
    static String value = "No mathing key"; // default value

    public static String findKey(JSONObject json, String key) {

        Iterator keys = json.keys();
        while(keys.hasNext()) {
            // loop to find the exact key
            String currentKey = (String)keys.next();
            if (currentKey.equals(key)) {
                // get the value of the key as match found
                value =  String.valueOf(json.get(currentKey));
                break ;
            } else if (json.get(currentKey) instanceof JSONObject) {
                findKey(json.getJSONObject(currentKey),key);
            }
        }
        return value;
    }
}