package com.ht.utils;

import java.util.List;

public record SearchResponse<T>(List<T> data, Long total) {
}
