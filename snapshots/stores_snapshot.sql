{% snapshot stores_snapshot %}

    {{
        config(
            target_schema='staging_snapshot',
            unique_key='location_id',
            strategy='check',
            check_cols=['location_name', 'tax_rate']
        )
    }}

    SELECT * FROM {{ ref('stg_locations') }}

{% endsnapshot %}
