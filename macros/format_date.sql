{% macro format_date(date_col, format_str='%Y-%m-%d') %}
    TO_CHAR({{ date_col }}, '{{ format_str }}')
{% endmacro %}