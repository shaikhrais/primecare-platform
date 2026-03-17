// PAGE IDENTITY: T48 · KB Article Editor
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function KBArticle() {
    return (
        <PageTemplate pageId="T48" title="✏️ KB Article Editor" subtitle="Create and edit knowledge base articles with rich text formatting"
            sectionData={{
                'T48.form': { cardGrid: { items: [
                    { icon: '📝', title: 'Article Content', subtitle: 'Rich text editor, headings, lists & media' },
                    { icon: '🏷️', title: 'Metadata', subtitle: 'Category, tags, author & publish date' },
                    { icon: '🔗', title: 'Related Articles', subtitle: 'Link related SOPs, policies & guides' },
                    { icon: '👥', title: 'Access Control', subtitle: 'Visibility, role-based access & approval chain' },
                ], columns: 2 } },
            }}
        />
    );
}
