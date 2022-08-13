CREATE TABLE comments(
    comment_id          uuid,
    bug_id              uuid NOT NULL,
    auther              VARCHAR(30),
    comment             TEXT,
    created_at          timestamptz NOT NULL
);

CREATE TABLE tree_path(
    ancestor        uuid NOT NULL,
    descendant      uuid NOT NULL,
    PRIMARY KEY(ancestor, descendant)
);

ALTER TABLE ONLY tree_path ADD CONSTRAINT ancestor_fkey FOREIGN KEY (ancestor) REFERENCES comments (comment_id);
ALTER TABLE ONLY tree_path ADD CONSTRAINT descendant_fkey FOREIGN KEY (descendant) REFERENCES comments (comment_id);


-- currecntly there is no policy 
ALTER TABLE comments
  ENABLE ROW LEVEL SECURITY;

-- currecntly there is no policy 
ALTER TABLE tree_path
  ENABLE ROW LEVEL SECURITY;




-------------------------------------------
-------------------------------------------
--------     data for comment      --------
-------------------------------------------
-------------------------------------------

-- 1st comments
INSERT INTO comments(comment_id, bug_id, auther, comment, created_at) VALUES ('51b45f83-4511-4510-8f52-242160493f60', '02baa04d-17e8-4eb5-9615-e7addc98f65e', 'bob', 'hey, this is a nice keyboard', now());

-- 2nd comment, parent 1
INSERT INTO comments(comment_id, bug_id, auther, comment, created_at) VALUES ('4ac4faff-b800-449c-bfbe-d38dabdce2f3', '02baa04d-17e8-4eb5-9615-e7addc98f65e', 'shin', 'thank you I bought this keyboard at keychron', now());

-- 3rd comment, parent 1
INSERT INTO comments(comment_id, bug_id, auther, comment, created_at) VALUES ('3903163e-2a1e-4d9b-b790-a6c36628a9de', '02baa04d-17e8-4eb5-9615-e7addc98f65e', 'john', 'actually, I bought it from amazon', now());

-- 4th comment, parent 2
INSERT INTO comments(comment_id, bug_id, auther, comment, created_at) VALUES ('e3a03a25-1645-4e16-a16b-6d2539b89c50', '02baa04d-17e8-4eb5-9615-e7addc98f65e', 'bob', 'I bought it at keychron too', now());



-------------------------------------------
-------------------------------------------
--------    data for tree_path     --------
-------------------------------------------
-------------------------------------------

INSERT INTO tree_path(ancestor, descendant) VALUES ('829bedd9-3d3f-49c9-a54f-ef50aef5db63', '5ff842a3-2785-4d9f-8d45-170ade55268f');

-- 2nd comment
INSERT INTO tree_path (ancestor, descendant)
    select
        t.ancestor,
        '4ac4faff-b800-449c-bfbe-d38dabdce2f3'::uuid as descendant
    from
        tree_path t
    where
        t.descendant = '51b45f83-4511-4510-8f52-242160493f60'
    UNION ALL select '4ac4faff-b800-449c-bfbe-d38dabdce2f3'::uuid , '4ac4faff-b800-449c-bfbe-d38dabdce2f3'::uuid;


-- 3nd comment
INSERT INTO tree_path (ancestor, descendant)
    select
        t.ancestor,
        '3903163e-2a1e-4d9b-b790-a6c36628a9de'::uuid as descendant
    from
        tree_path t
    where
        t.descendant = '51b45f83-4511-4510-8f52-242160493f60'
    UNION ALL select '3903163e-2a1e-4d9b-b790-a6c36628a9de'::uuid , '3903163e-2a1e-4d9b-b790-a6c36628a9de'::uuid;



-- 4th comment
INSERT INTO tree_path (ancestor, descendant)
    select
        t.ancestor,
        'e3a03a25-1645-4e16-a16b-6d2539b89c50'::uuid as descendant
    from
        tree_path t
    where
        t.descendant = '4ac4faff-b800-449c-bfbe-d38dabdce2f3'
    UNION ALL select 'e3a03a25-1645-4e16-a16b-6d2539b89c50'::uuid , 'e3a03a25-1645-4e16-a16b-6d2539b89c50'::uuid;









-- idea
INSERT INTO tree_path (ancestor, descendant)
    SELECT
        t.ancestor,
        :new_node
    FROM
        tree_path t
    WHERE
        t.descendant = :parent_node
    UNION ALL
        SELECT new_node, new_node


-- query all comment but the order is not maintained
select
    tp.ancestor,
    tp.descendant,
    c.comment
from
    comments c
        inner join tree_path tp
            on c.comment_id = tp.descendant
    where tp.ancestor = '51b45f83-4511-4510-8f52-242160493f60' and
          c.bug_id = '02baa04d-17e8-4eb5-9615-e7addc98f65e';


-- query from the buttom
select
    *
from
    comments c
        inner join tree_path tp
            on c.comment_id = tp.ancestor
    where tp.descendant = 'e3a03a25-1645-4e16-a16b-6d2539b89c50';