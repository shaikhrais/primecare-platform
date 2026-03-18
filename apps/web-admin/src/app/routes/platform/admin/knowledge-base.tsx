import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H8-KnowledgeBase.tsx ---
// PAGE IDENTITY: H8 · Knowledge Base

export function KnowledgeBase() {
    return (
        <PageTemplate pageId="H8" title="📚 Knowledge Base" subtitle="Internal wiki, SOPs, training resources & policy documentation"
            sectionData={PageSectionRegistry['H8']}
        />
    );
}

// --- Merged from T48-KBArticle.tsx ---
// PAGE IDENTITY: T48 · KB Article Editor

export function KBArticle() {
    return (
        <PageTemplate pageId="T48" title="✏️ KB Article Editor" subtitle="Create and edit knowledge base articles with rich text formatting"
            sectionData={PageSectionRegistry['T48']}
        />
    );
}
