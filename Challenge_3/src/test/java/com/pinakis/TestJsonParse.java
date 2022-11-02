package com.pinakis;

import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.json.JSONObject;

public class TestJsonParse {

    @Before
    public void setUp() throws Exception{}

    @After
    public void tearDown() throws Exception{}

    @Test
    public void testParse() {
        String input = "{\"a\":{\"b\":{\"c\":\"d\"}}}";
        JSONObject inputJSONOBject = new JSONObject(input);

        assertEquals("d", JsonParse.findKey(inputJSONOBject,"c"));
    }
}